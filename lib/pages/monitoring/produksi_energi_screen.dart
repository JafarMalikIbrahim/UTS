import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/produksi_energi_chart.dart';

class ProduksiEnergiScreen extends StatefulWidget {
  final String idCluster;
  const ProduksiEnergiScreen({Key? key, required this.idCluster})
      : super(key: key);

  @override
  State<ProduksiEnergiScreen> createState() => _ProduksiEnergiScreenState();
}

class _ProduksiEnergiScreenState extends State<ProduksiEnergiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 12, 144, 125),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(10, 16),
                        blurRadius: 15,
                        spreadRadius: -20,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Produksi Energi (kWh)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // menampilkan bar chart dari produksi energi dan load
                        ProduksiEnergiChart(
                          idCluster: widget.idCluster,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
