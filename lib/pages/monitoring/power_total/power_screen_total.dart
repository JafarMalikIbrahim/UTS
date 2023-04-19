import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/power_total/power_chart_total.dart';

class PowerScreenTotal extends StatefulWidget {
  final String idCluster;
  const PowerScreenTotal({Key? key, required this.idCluster}) : super(key: key);

  @override
  State<PowerScreenTotal> createState() => _PowerScreenTotalState();
}

class _PowerScreenTotalState extends State<PowerScreenTotal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Produksi Realtime Energy Listrik (EBT)"),
        backgroundColor: const Color.fromARGB(225, 18, 149, 117),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Produksi Realtime \nEnergy Listrik (EBT)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                PowerChartTotal(
                  idCluster: widget.idCluster,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
