import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/detail_asset.dart';

class AsetCard extends StatelessWidget {
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

  const AsetCard({
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailAsset(
              comisioning: comisioning,
              docAsetId: docAsetId,
              foto: foto,
              garansiAset: garansiAset,
              img: img,
              jenisAset: jenisAset,
              kodeAset: kodeAset,
              kondisiAset: kondisiAset,
              lokasiAset: lokasiAset,
              merkAset: merkAset,
              namaAset: namaAset,
              spekDasar1: spekDasar1,
              spekDasar2: spekDasar2,
              spekDasar3: spekDasar3,
              spekUmum: spekUmum,
              status: kondisiAset,
              statusVerifikasi: statusVerifikasi,
              tglBeroperasi: tglBeroperasi,
              tglDipasang: tglDipasang,
              umurAset: umurAset,
              vendorPengadaan: vendorPengadaan,
              vendorPemasangan: vendorPemasangan,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: const Color(0xff000000).withOpacity(0.06),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Image(
                image: AssetImage(img),
                width: 50,
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // kode aset
                        Text(
                          kodeAset,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(225, 18, 149, 117),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          namaAset,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // icon status
                        Icon(
                          status == "Aktif"
                              ? Icons.task_alt
                              : Icons.highlight_off,
                          color: status == "Aktif" ? Colors.green : Colors.red,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      // width: 100,
                      child: Text(
                        status,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
