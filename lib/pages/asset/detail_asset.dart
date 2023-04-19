import 'package:flutter/material.dart';

class DetailAsset extends StatefulWidget {
  final String docAsetId;
  // final String namaCluster;
  // final String jenisPerangkat;
  final String comisioning;
  final String foto;
  final String garansiAset;
  final String jenisAset;
  final String kodeAset;
  final String kondisiAset;
  final String lokasiAset;
  final String merkAset;
  final String namaAset;
  final String spekDasar1;
  final String spekDasar2;
  final String spekDasar3;
  final String spekUmum;
  final String tglBeroperasi;
  final String tglDipasang;
  final int umurAset;
  final String vendorPemasangan;
  final String vendorPengadaan;
  final String status;
  final String img;
  final String statusVerifikasi;

  const DetailAsset({
    Key? key,
    required this.docAsetId,
    // required this.namaCluster,
    // required this.jenisPerangkat,
    required this.comisioning,
    required this.foto,
    required this.garansiAset,
    required this.jenisAset,
    required this.kodeAset,
    required this.kondisiAset,
    required this.lokasiAset,
    required this.merkAset,
    required this.namaAset,
    required this.spekDasar1,
    required this.spekDasar2,
    required this.spekDasar3,
    required this.spekUmum,
    required this.tglBeroperasi,
    required this.tglDipasang,
    required this.umurAset,
    required this.vendorPemasangan,
    required this.vendorPengadaan,
    required this.status,
    required this.img,
    required this.statusVerifikasi,
  }) : super(key: key);

  @override
  State<DetailAsset> createState() => _DetailAssetState();
}

class _DetailAssetState extends State<DetailAsset> {
  String statusKonfirmasi = 'Menunggu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Aset"),
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
              children: [
                // Container(
                //   margin: const EdgeInsets.only(
                //     bottom: 30,
                //     top: 8,
                //   ),
                //   // height: MediaQuery.of(context).size.height * 0.32,
                //   // width: MediaQuery.of(context).size.width * 0.45,
                //   child: Stack(
                //     children: [
                //       Container(
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           boxShadow: <BoxShadow>[
                //             BoxShadow(
                //               color: Colors.black.withOpacity(0.2),
                //               blurRadius: 29,
                //               offset: const Offset(8, 8),
                //               spreadRadius: 3,
                //             ),
                //             BoxShadow(
                //               color: Colors.black.withOpacity(0.2),
                //               blurRadius: 25,
                //               offset: const Offset(-8, -8),
                //               // spreadRadius: 3,
                //             )
                //           ],
                //         ),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(20),
                //           child: Image(
                //             image: AssetImage('img/no-image.png'),
                //             // image: NetworkImage(
                //             //   widget.urlCoverBook,
                //             // ),
                //             fit: BoxFit.fill,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // nama Aset
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    widget.namaAset,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // kode aset
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.kodeAset,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(225, 18, 149, 117),
                    ),
                  ),
                ),

                // merk
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Merk Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.merkAset,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // cluster
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Cluster',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Cluster Tuban',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // jenis perangkat
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Jenis Perangkat',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'PLTB',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // jenis aset
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Jenis Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.jenisAset,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // lokasi
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Lokasi',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.lokasiAset,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // status verifikasi
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Status Verifikasi',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.statusVerifikasi,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // tanggal dipasang
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Tanggal Dipasang',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.tglDipasang,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // tanggal beroperasi
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Tanggal Mulai Beroperasi',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.tglBeroperasi,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // umur aset
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Umur Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.umurAset.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // garansi aset
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Garansi Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.garansiAset,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // kondisi aset
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Kondisi Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.kodeAset,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // vendor pengadaan
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Vendor Pengadaan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.vendorPengadaan,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // vendor pemasangan
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Vendor Pemasangan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.vendorPemasangan,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // Comisioning
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Comisioning',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.comisioning,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // Spek dasar 1
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Spek Dasar 1',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.spekDasar1,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // Spek dasar 2
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Spek Dasar 2',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.spekDasar2,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // Spek dasar 3
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Spek Dasar 3',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.spekDasar3,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                // Spek umum
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Spek Umum',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.spekUmum,
                    style: const TextStyle(fontSize: 16),
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
