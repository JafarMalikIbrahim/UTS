import 'package:flutter/material.dart';

class DetailPengecekan extends StatefulWidget {
  // final String documentId;
  // final String kodeAset;
  // final String namaAset;
  // final String namaPetugas;
  // final String tanggal;
  // final String status;
  const DetailPengecekan({
    Key? key,
    // required this.documentId,
    // required this.kodeAset,
    // required this.namaAset,
    // required this.namaPetugas,
    // required this.tanggal,
    // required this.status,
  }) : super(key: key);

  @override
  State<DetailPengecekan> createState() => _DetailPengecekanState();
}

class _DetailPengecekanState extends State<DetailPengecekan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // nama Aset
                SizedBox(
                  child: Text(
                    "Nama Aset",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // kode aset
                SizedBox(
                  child: Text(
                    "Kode Aset",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(225, 0, 74, 173),
                    ),
                  ),
                ),

                // status konfirmasi
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Status Pengecekan Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Sudah dikonfirmasi',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // lokasi aset
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Lokasi Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Cluster Tuban',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // petugas
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Nama Petugas',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Nama Petugas',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // tanggal pengecekan
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Tanggal Pengecekan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '02 Feb 2022',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
