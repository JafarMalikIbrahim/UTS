import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/wind_turbine.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_aset/widget/realtime_card.dart';

class WtRealtime extends StatefulWidget {
  const WtRealtime({Key? key}) : super(key: key);

  @override
  State<WtRealtime> createState() => _WtRealtimeState();
}

class _WtRealtimeState extends State<WtRealtime> {
  List<dynamic> wtdata = [];
  late double power;
  // Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!));
  }

  final DateTime? _dateTime = DateTime.now();
  // mangambil data
  Future<void> fetchData(String date) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/wind-turbine/status");
    // Uri url=Uri.parse("127.0.0.1:1880/w/history");
    var response = await http.post(
      url,
      body: {
        "id": "1",
        "date": date,
      },
    );

    if (mounted) {
      setState(() {
        wtdata = json.decode(response.body)['real_data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return wtdata.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 16,
                    children: [
                      RealtimeCard(
                        img: 'img/turbine.png',
                        title: "RPM Bilah",
                        subTitle: "${wtdata.last['rpm_bilah']}",
                      ),
                      RealtimeCard(
                        img: 'img/turbine.png',
                        title: "RPM Generator",
                        subTitle: "${wtdata.last['rpm_generator']}",
                      ),
                      RealtimeCard(
                        img: 'img/turbine.png',
                        title: "Volt ac",
                        subTitle: "${wtdata.last['volt_ac']}",
                      ),
                      RealtimeCard(
                        img: 'img/turbine.png',
                        title: "Volt dc",
                        subTitle: "${wtdata.last['volt_dc']}",
                      ),
                      RealtimeCard(
                        img: 'img/turbine.png',
                        title: "Ampere ac",
                        subTitle: "${wtdata.last['ampere_ac']}",
                      ),
                      RealtimeCard(
                        img: 'img/turbine.png',
                        title: "Ampere dc",
                        subTitle: "${wtdata.last['ampere_dc']}",
                      ),
                      RealtimeCard(
                        img: 'img/power.png',
                        title: "Power",
                        subTitle: "${wtdata.last['value']}",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    // Text("RPM 1 ${wtdata.last['rpm_1']}");
  }
}
