import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/weather_station.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ProduksiEnergiChart extends StatefulWidget {
  final String idCluster;
  const ProduksiEnergiChart({Key? key, required this.idCluster})
      : super(key: key);

  @override
  _ProduksiEnergiChartState createState() => _ProduksiEnergiChartState();
}

class _ProduksiEnergiChartState extends State<ProduksiEnergiChart> {
  // final List<WtData> _data = [];
  // final List<SpData> _chartSpData = [];
  final List<WsData> _data = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

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
        fetchData(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
    _tooltipBehavior = TooltipBehavior(enable: true);
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

  // mangambil data produksi energi dan load
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
    // return (_data.isNotEmpty)
    return FutureBuilder(
      future: Future.delayed(
          const Duration(seconds: 2),
          () => fetchData(
              DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load data.'));
        } else if (_data.isEmpty) {
          return datePicker();
        } else {
          return Column(
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
                legend: Legend(
                  isVisible: true,
                  height: '50%',
                  width: '100%',
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries<dynamic, dynamic>>[
                  StackedColumnSeries<WsData, dynamic>(
                    name: 'PLTB',
                    groupName: 'Produksi Energi',
                    dataSource: _data,
                    width: 1.0,
                    spacing: 0.2, // dataLabelSettings: const DataLabelSettings(
                    //     isVisible: true, showCumulativeValues: true),
                    color: const Color.fromARGB(255, 42, 73, 247),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.windSpeed,
                  ),
                  StackedColumnSeries<WsData, dynamic>(
                    name: 'PLTS',
                    groupName: 'Produksi Energi',
                    dataSource: _data,
                    width: 1.0,
                    spacing: 0.2,
                    // dataLabelSettings: const DataLabelSettings(
                    //     isVisible: true, showCumulativeValues: true),
                    color: const Color.fromARGB(255, 240, 66, 35),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.temp,
                  ),
                  StackedColumnSeries<WsData, dynamic>(
                    name: 'Diesel',
                    groupName: 'Produksi Energi',
                    dataSource: _data,
                    width: 1.0,
                    spacing: 0.2,
                    // dataLabelSettings: const DataLabelSettings(
                    //     isVisible: true, showCumulativeValues: true),
                    color: const Color.fromARGB(255, 255, 241, 39),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.uvIndex,
                  ),
                  StackedColumnSeries<WsData, dynamic>(
                    name: 'Load',
                    groupName: 'Load',
                    dataSource: _data,
                    width: 1.0,
                    spacing: 0.2,
                    // dataLabelSettings: const DataLabelSettings(
                    //     isVisible: true, showCumulativeValues: true),
                    color: const Color.fromARGB(255, 96, 218, 48),
                    xValueMapper: (WsData data, _) => data.dateUtc,
                    yValueMapper: (WsData data, _) => data.windDir,
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.place),
            const Text('Tuban'),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.expand_more),
            ),
          ],
        ),
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
