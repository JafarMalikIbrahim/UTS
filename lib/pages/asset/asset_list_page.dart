import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/aset_card.dart';

// class AssetList extends StatefulWidget {
//   const AssetList({Key? key}) : super(key: key);

//   @override
//   State<AssetList> createState() => _AssetListState();
// }

// class _AssetListState extends State<AssetList> {
//   var idSelected = 0;
//   Widget currentTab() {
//     return _chipBarList[idSelected].bodyWidget;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(225, 12, 144, 125),
//         elevation: 0,
//         title: const Text('Data Asset'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(225, 12, 144, 125),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//             // search
//             child: TextField(
//               onChanged: (value) {},
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: "Cari...",
//                 prefixIcon: const Icon(
//                   Icons.search,
//                   size: 26.0,
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.transparent),
//                   borderRadius: BorderRadius.circular((10.0)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.transparent),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.transparent),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           // choice chip
//           SizedBox(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: listChip(),
//             ),
//           ),
//           // content
//           Expanded(
//             child: Center(child: currentTab()),
//           ),
//         ],
//       ),
//       floatingActionButton:
//           StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         stream: DatabaseService().userRole(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container();
//           }
//           if (snapshot.hasData) {
//             String role = snapshot.data!.data()!['role'];
//             // cek user untuk menampilkan tombol tambah data aset
//             if (role == 'Pemilik Proyek') {
//               return FloatingActionButton(
//                 child: const Icon(Icons.add),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => JenisAsset(),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               null;
//             }
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   listChip() {
//     return Row(
//       children: _chipBarList
//           .map(
//             (item) => Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: ChoiceChip(
//                 label: Text(item.title),
//                 selected: idSelected == item.id,
//                 labelStyle: TextStyle(
//                   color: idSelected == item.id ? Colors.white : Colors.black,
//                 ),
//                 selectedColor: const Color.fromARGB(225, 12, 144, 125),
//                 onSelected: (_) => setState(() => idSelected = item.id),
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }

//   void _showBottomSheet() {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Column();
//         });
//   }
// }

class BuilderAset extends StatelessWidget {
  final stream;
  const BuilderAset({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String docAsetId =
                              snapshot.data!.docs[index].id;
                          // String cluster = documentSnapshot['cluster'];
                          // String jenisPerangkat = documentSnapshot['cluster'];
                          String comisioningAset =
                              documentSnapshot['comisioning'];
                          String fotoAset = documentSnapshot['foto'];
                          String garansiAset = documentSnapshot['garansi'];
                          String jenisAset = documentSnapshot['jenis'];
                          String kodeAset = documentSnapshot['kode'];
                          String kondisiAset = documentSnapshot['kondisi'];
                          String lokasiAset = documentSnapshot['lokasi'];
                          String merekAsetAset = documentSnapshot['merk'];
                          String namaAset = documentSnapshot['nama'];
                          String spekDasar1 = documentSnapshot['spekDasar1'];
                          String spekDasar2 = documentSnapshot['spekDasar2'];
                          String spekDasar3 = documentSnapshot['spekDasar3'];
                          String spekUmum = documentSnapshot['spekUmum'];
                          String tglBeroperasi =
                              documentSnapshot['tglBeroperasi'];
                          String tglDipasang = documentSnapshot['tglDipasang'];
                          int umurAset = documentSnapshot['umurAset'];
                          String vendorPemasangan =
                              documentSnapshot['vendorPemasangan'];
                          String vendorPengadaan =
                              documentSnapshot['vendorPengadaan'];
                          String statusVerifikasi =
                              documentSnapshot['statusVerifikasi'];
                          String img = '';
                          if (jenisAset == 'sensor') {
                            img = 'img/sensor.png';
                          } else if (jenisAset == 'elektrikal') {
                            img = 'img/mekanik.png';
                          } else if (jenisAset == 'jaringan') {
                            img = 'img/jaringan.png';
                          } else if (jenisAset == 'mekanik') {
                            img = 'img/mekanik.png';
                          } else if (jenisAset == 'sipil') {
                            img = 'img/mekanik.png';
                          }
                          return AsetCard(
                            comisioning: comisioningAset,
                            docAsetId: docAsetId,
                            foto: fotoAset,
                            garansiAset: garansiAset,
                            img: img,
                            jenisAset: jenisAset,
                            kodeAset: kodeAset,
                            kondisiAset: kondisiAset,
                            lokasiAset: lokasiAset,
                            merkAset: merekAsetAset,
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
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          );
        },
      ),
      floatingActionButton:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: DatabaseService().userRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasData) {
            String role = snapshot.data!.data()!['role'];
            // cek user untuk menampilkan tombol tambah data aset
            if (role == 'Operator Vendor') {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddAssetGudang(),
                  //   ),
                  // );
                },
              );
            } else {
              null;
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}

// // // list untuk choice chip
// final _chipBarList = <ItemChipBar>[
//   ItemChipBar(
//     0,
//     'Semua',
//     BuilderAset(
//       stream: DatabaseService().listAset(),
//     ),
//   ),
//   ItemChipBar(
//     1,
//     'Belum Dikonfirmasi',
//     BuilderAset(
//       stream: DatabaseService().listAsetMenunggu(),
//     ),
//   ),
//   ItemChipBar(
//     2,
//     'Diterima',
//     BuilderAset(
//       stream: DatabaseService().listAsetDiterima(),
//     ),
//   ),
//   ItemChipBar(
//     3,
//     'Ditolak',
//     BuilderAset(
//       stream: DatabaseService().listAsetDitolak(),
//     ),
//   ),
// ];
