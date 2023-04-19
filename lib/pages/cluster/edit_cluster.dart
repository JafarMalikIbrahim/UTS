import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class EditCluster extends StatefulWidget {
  final documentId;
  final String currentId;
  final String currentCluster;
  final double currentLat;
  final double currentLng;
  const EditCluster({
    Key? key,
    this.documentId,
    required this.currentCluster,
    required this.currentLat,
    required this.currentLng,
    required this.currentId,
  }) : super(key: key);

  @override
  State<EditCluster> createState() => _EditClusterState();
}

class _EditClusterState extends State<EditCluster> {
  final _editClusterKey = GlobalKey<FormState>();

  // text field controller
  TextEditingController idC = TextEditingController();
  TextEditingController clusterC = TextEditingController();
  TextEditingController latC = TextEditingController();
  TextEditingController lngC = TextEditingController();

  @override
  void initState() {
    idC = TextEditingController(text: widget.currentId);
    clusterC = TextEditingController(text: widget.currentCluster);
    latC = TextEditingController(text: widget.currentLat.toString());
    lngC = TextEditingController(text: widget.currentLng.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
      body: Form(
        key: _editClusterKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // id
                InputForm(
                  title: "id",
                  controller: idC,
                  inputType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diiisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // nama
                InputForm(
                  title: "Nama Cluster",
                  controller: clusterC,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diiisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // lokasi Cluster
                InputForm(
                  title: "Latitude",
                  controller: latC,
                  inputType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diiisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // Longitude
                InputForm(
                  title: "Longitude",
                  controller: lngC,
                  inputType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diiisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                //submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_editClusterKey.currentState!.validate()) {
                        await DatabaseService().updateCluster(
                          documentId: widget.documentId,
                          id: idC.text,
                          nama: clusterC.text,
                          lat: double.parse(latC.text),
                          lng: double.parse(lngC.text),
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cluster Berhasil Diupdate'),
                          ),
                        );
                      } else {
                        const SnackBar(
                          content: Text('Gagal '),
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
