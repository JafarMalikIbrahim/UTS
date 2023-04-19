import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/wind_turbine.dart';
import 'package:manajemen_aset/pages/monitoring/wind_turbine/sf_chart_wt.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class WtChart extends StatefulWidget {
  final String idWt;
  const WtChart({Key? key, required this.idWt}) : super(key: key);

  @override
  _WtChartState createState() => _WtChartState();
}

class _WtChartState extends State<WtChart> {
  List<WtData> _dataWt = [];
  List<WtDailyProd> _dailyProd = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;
  late Future fetchFuture;
  late Future fetchDailyProd;

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
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFuture =
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt);
    fetchDailyProd =
        fetchDataProd(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt);
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // mangambil data wind turbine
  Future fetchData(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/wind-turbine/get-day-alldata");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['data'];

    List<WtData> dataWt = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime = DateFormat('HH:mm:ss')
          .format(DateTime.parse(realData[i]['datetime']));
      var windSpeed = realData[i]['wind_speed']?.toDouble() ?? 0.0;
      var rpmBilah = realData[i]['rpm_bilah']?.toDouble() ?? 0.0;
      var rpmGenerator = realData[i]['rpm_generator']?.toDouble() ?? 0.0;
      var ampereDc = realData[i]['ampere_dc']?.toDouble() ?? 0.0;
      var voltDc = realData[i]['volt_dc']?.toDouble() ?? 0.0;
      var powerWatt = realData[i]['power_watt']?.toDouble() ?? 0.0;

      dataWt.add(WtData(
        dateTime,
        windSpeed,
        rpmBilah,
        rpmGenerator,
        powerWatt,
        ampereDc,
        voltDc,
      ));
    }

    // if (mounted) {
    //   setState(() {
    //     _dataWt = dataWt;
    //   });
    // }
    return _dataWt = dataWt;
  }

  // mangambil data wind turbine
  Future<WtDailyProd> fetchDataProd(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/wind-turbine/daily-production");
    var response = await http.post(
      url,
      body: {"id": id, "date_day": date},
    );

    final jsonData = json.decode(response.body);
    final idP = jsonData['id'];
    final day =
        DateFormat('yyyy-mm-dd').format(DateTime.parse(jsonData['day']));
    final avgWindSpeed = jsonData['avg_wind_speed']?.toDouble() ?? 0.0;
    final avgCurahHujan = jsonData['avg_curah_hujan']?.toDouble() ?? 0.0;
    final totalKwh = jsonData['total_kwh']?.toDouble() ?? 0.0;
    final totalWatt = jsonData['total_watt']?.toDouble() ?? 0.0;

    List<WtDailyProd> dailyProd = [];

    dailyProd.add(WtDailyProd(
      idP,
      day,
      avgWindSpeed,
      avgCurahHujan,
      totalKwh,
      totalWatt,
    ));

    // if (mounted) {
    //   setState(() {
    //     _dataWt = dataWt;
    //   });
    // }
    return WtDailyProd(
        idP, day, avgWindSpeed, avgCurahHujan, totalKwh, totalWatt);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 2),
        () =>
            fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt),
      ),
      // future: fetchFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Center(
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
                FutureBuilder<WtDailyProd>(
                    future: Future.delayed(
                      const Duration(seconds: 2),
                      () => fetchDataProd(
                          DateFormat('yyyy-MM-dd').format(_dateTime!),
                          widget.idWt),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final dailyProd = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Produksi Energi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${dailyProd!.totalKwh} kWh',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text("Total Produksi");
                      }
                    }),
                const SizedBox(
                  height: 8,
                ),
                SfChartWt(
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  dataWt: _dataWt,
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
        Row(
          children: [
            const Icon(Iconsax.calendar_1),
            const SizedBox(
              width: 16,
            ),
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
        ),
      ],
    );
  }
}
