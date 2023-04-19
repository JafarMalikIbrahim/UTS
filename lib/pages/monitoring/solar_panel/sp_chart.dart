import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/models/solar_panel.dart';
import 'package:manajemen_aset/pages/monitoring/solar_panel/sf_chart_sp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SpChart extends StatefulWidget {
  final String idSp;
  const SpChart({Key? key, required this.idSp}) : super(key: key);

  @override
  _SpChartState createState() => _SpChartState();
}

class _SpChartState extends State<SpChart> {
  List<SpData> _dataSp = [];
  List<SpDailyProd> _dailyProd = [];
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
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idSp);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFuture =
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idSp);
    fetchDailyProd =
        fetchDataProd(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idSp);
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

  // mangambil data realtime solar panel
  Future fetchData(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/solar-panel/realtime-by-date");
    var response = await http.post(
      url,
      body: {"id": id, "date": date},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['data'];

    List<SpData> dataSp = [];

    for (var i = 0; i < realData.length; i++) {
      var dateTime = DateFormat('HH:mm:ss')
          .format(DateTime.parse(realData[i]['datetime']));
      var solarRad = realData[i]['solar_rad']?.toDouble() ?? 0.0;
      var energiPrimer = realData[i]['energi_primer']?.toDouble() ?? 0.0;
      var volt = realData[i]['volt']?.toDouble() ?? 0.0;
      var ampere = realData[i]['ampere']?.toDouble() ?? 0.0;
      var power = realData[i]['power']?.toDouble() ?? 0.0;

      dataSp.add(SpData(
        dateTime,
        solarRad,
        energiPrimer,
        volt,
        ampere,
        power,
      ));
    }

    // if (mounted) {
    //   setState(() {
    //     _dataWt = dataWt;
    //   });
    // }
    return _dataSp = dataSp;
  }

  // mangambil data produksi harian solar panel
  Future<SpDailyProd> fetchDataProd(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/solar-panel/daily-production");
    var response = await http.post(
      url,
      body: {"id": id, "date_day": date},
    );

    final jsonData = json.decode(response.body);
    final idP = jsonData['id'];
    final day =
        DateFormat('yyyy-mm-dd').format(DateTime.parse(jsonData['day']));
    final powerWatt = jsonData['power_watt']?.toDouble() ?? 0.0;
    final powerKwh = jsonData['power_kwh']?.toDouble() ?? 0.0;

    List<SpDailyProd> dailyProd = [];

    dailyProd.add(SpDailyProd(
      idP,
      day,
      powerWatt,
      powerKwh,
    ));

    // if (mounted) {
    //   setState(() {
    //     _dataWt = dataWt;
    //   });
    // }
    return SpDailyProd(idP, day, powerWatt, powerKwh);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 2),
        () =>
            fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idSp),
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
                FutureBuilder<SpDailyProd>(
                    future: Future.delayed(
                      const Duration(seconds: 2),
                      () => fetchDataProd(
                          DateFormat('yyyy-MM-dd').format(_dateTime!),
                          widget.idSp),
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
                              '${dailyProd!.powerKwh} kWh',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                const SizedBox(
                  height: 8,
                ),
                SfChartSp(
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  dataSp: _dataSp,
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
