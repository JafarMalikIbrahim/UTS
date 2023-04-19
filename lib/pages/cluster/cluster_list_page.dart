import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/cluster/add_cluster.dart';
import 'package:manajemen_aset/pages/cluster/edit_cluster.dart';
import 'package:manajemen_aset/service/database.dart';

class ClusterList extends StatefulWidget {
  const ClusterList({Key? key}) : super(key: key);

  @override
  State<ClusterList> createState() => _ClusterListState();
}

class _ClusterListState extends State<ClusterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: DatabaseService().listCluster(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(225, 18, 149, 117),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  // search
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Cari...",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 26.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular((10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final documentSnapshot = snapshot.data!.docs[index];
                      final String docId = snapshot.data!.docs[index].id;
                      String idCluster = documentSnapshot['id'];
                      String namaCluster = documentSnapshot['nama'];
                      GeoPoint geoPoint = documentSnapshot['lokasi'];
                      double lat = geoPoint.latitude;
                      double lng = geoPoint.longitude;
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Card(
                            child: ListTile(
                              horizontalTitleGap: 0.1,
                              contentPadding: const EdgeInsets.all(4),
                              leading: const Icon(
                                Icons.location_on,
                                size: 30,
                                color: Color.fromARGB(225, 18, 149, 117),
                              ),
                              title: Text(namaCluster),
                              trailing: PopupMenuButton<int>(
                                iconSize: 20,
                                itemBuilder: (context) => [
                                  // PopupMenuItem 1
                                  PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit),
                                        SizedBox(width: 10),
                                        Text("Edit Cluster")
                                      ],
                                    ),
                                  ),
                                  // PopupMenuItem 2
                                  PopupMenuItem(
                                    value: 2,
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete),
                                        SizedBox(width: 10),
                                        Text("Hapus Cluster")
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 1) {
                                    // edit cluster
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCluster(
                                          documentId: docId,
                                          currentId: idCluster,
                                          currentCluster: namaCluster,
                                          currentLat: lat,
                                          currentLng: lng,
                                        ),
                                      ),
                                    );
                                  } else if (value == 2) {
                                    // hapus cluster
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Hapus"),
                                        content: Text(
                                          "Apakah anda yakin akan menghapus $namaCluster? ",
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Batal",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    225, 125, 122, 116),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await DatabaseService()
                                                  .deleteCluster(
                                                documentId: docId,
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Hapus"),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
            if (role == 'Admin IT') {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCluster(),
                    ),
                  );
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
