import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/weather_station.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class WsChart extends StatefulWidget {
  final String idWs;
  const WsChart({Key? key, required this.idWs}) : super(key: key);

  @override
  _WsChartState createState() => _WsChartState();
}

class _WsChartState extends State<WsChart> {
  final List<WsData> _data = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

  DateTime? _dateTime = DateTime.now();
  // menampilkan date picker
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        _dateTime = _dateTime;
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // mangambil data
  Future<void> fetchData(String date, String id) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/weather-station/history");
    var response = await http.post(
      url,
      body: {
        "id": id,
        "date": date,
      },
    );
    final jsonData = json.decode(response.body);

    if (mounted) {
      setState(() {
        _data.clear();
        for (var data in jsonData) {
          _data.add(WsData(
            DateFormat('HH:mm:ss').format(DateTime.parse(data['date_utc'])),
            data['wind_speed'].toDouble(),
            data['wind_dir'].toDouble(),
            data['temp'].toDouble(),
            data['uv_index'].toDouble(),
            data['solar_rad'].toDouble(),
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_data.isNotEmpty)
        ? Column(
            children: [
              //date
              datePicker(),
              const Divider(thickness: 1),
              const SizedBox(
                height: 8,
              ),
              SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                trackballBehavior: _trackballBehavior,
                legend: Legend(
                  isVisible: true,
                  height: '50%',
                  width: '100%',
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                axes: <ChartAxis>[
                  NumericAxis(
                    name: 'yAxis',
                    // title: AxisTitle(
                    //   text: 'm/s',
                    //   textStyle: const TextStyle(fontSize: 12),
                    // ),
                    opposedPosition: true,
                    interval: 5,
                  )
                ],
                primaryXAxis: CategoryAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 3,
                ),
                series: <ChartSeries<WsData, dynamic>>[
                  SplineSeries<WsData, dynamic>(
                    name: 'Wind Speed',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 253, 223, 56),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.windSpeed,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.triangle,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<WsData, dynamic>(
                    name: 'Temp',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(225, 0, 74, 173),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.temp,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.triangle,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<WsData, dynamic>(
                    name: 'Uv Index',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(224, 255, 152, 34),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.uvIndex,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.triangle,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<WsData, dynamic>(
                    name: 'Solar Rad',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(224, 190, 27, 223),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.solarRad,
                    // yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                ],
              ),
            ],
          )
        : datePicker();
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_month_rounded),
            Text(_dateTime == null
                ? DateFormat('dd MM yyyy').format(DateTime.now())
                : DateFormat('dd MMM yyyy').format(_dateTime!)),
            IconButton(
              onPressed: () async {
                _showDatePicker();
              },
              icon: const Icon(Icons.expand_more),
            ),
          ],
        ),
      ],
    );
  }
}
