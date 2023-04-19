import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/realtime_energy.dart';
import 'package:manajemen_aset/pages/monitoring/power_total/sf_chart_p.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PowerChartTotal extends StatefulWidget {
  final String idCluster;
  const PowerChartTotal({Key? key, required this.idCluster}) : super(key: key);

  @override
  _PowerChartTotalState createState() => _PowerChartTotalState();
}

class _PowerChartTotalState extends State<PowerChartTotal> {
  // final List<WtData> _data = [];
  // final List<SpData> _chartSpData = [];
  List<RealtimeEnergy> _dataReal = [];
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
        fetchFuture = fetchData(
            DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
      });
    });
  }

  late Future fetchFuture;

  @override
  void initState() {
    super.initState();
    // _chartSpData = getSpData();
    fetchFuture = fetchData(
        DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster);
    // fetchDataSp();
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
      zoomMode: ZoomMode.x,
      // maximumZoomLevel: 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // mangambil data
  Future fetchData(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/wind-turbine/power-status");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> prodKwh = jsonData['prod_kwh'];

    List<RealtimeEnergy> dataReal = [];

    for (var i = 0; i < prodKwh.length; i++) {
      var dateUtc =
          DateFormat('HH:mm:ss').format(DateTime.parse(prodKwh[i]['date_utc']));
      var windSpeed = prodKwh[i]['wind_speed']?.toDouble() ?? 0.0;
      var powerWatt = prodKwh[i]['power_watt']?.toDouble() ?? 0.0;

      dataReal.add(RealtimeEnergy(
        dateUtc,
        windSpeed,
        powerWatt,
        0,
        0,
        0,
        0,
      ));
    }

    // if (mounted) {
    //   setState(() {
    //     _dataReal = dataReal;
    //   });
    // }
    return _dataReal = dataReal;
  }

  @override
  Widget build(BuildContext context) {
    // return (_dataReal.isNotEmpty)
    return FutureBuilder(
      future: Future.delayed(
          const Duration(seconds: 2),
          () => fetchData(
              DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idCluster)),
      // future: fetchFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                //date
                datePicker(),
                const Divider(thickness: 1),
                const SizedBox(
                  height: 8,
                ),
                SfChart(
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  dataReal: _dataReal,
                ),
              ],
            );
          }
        }
      },
    );
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Iconsax.calendar_1),
        const SizedBox(width: 16),
        Text(
          _dateTime == null
              ? DateFormat('dd/MM/yyyy').format(DateTime.now())
              : DateFormat('dd/MM/yyyy').format(_dateTime!),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        IconButton(
          onPressed: () async {
            _showDatePicker();
          },
          icon: const Icon(Iconsax.arrow_down_1),
        ),
      ],
    );
  }
}
