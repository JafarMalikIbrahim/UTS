import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class EditPerangkat extends StatefulWidget {
  final docClusterId;
  final docPerangkatId;
  final String currentId;
  final String currentKode;
  final String currentJenis;
  final String currentStatus;
  const EditPerangkat({
    Key? key,
    this.docClusterId,
    this.docPerangkatId,
    required this.currentId,
    required this.currentKode,
    required this.currentJenis,
    required this.currentStatus,
  }) : super(key: key);

  @override
  State<EditPerangkat> createState() => _EditPerangkatState();
}

class _EditPerangkatState extends State<EditPerangkat> {
  final _editPerangkatKey = GlobalKey<FormState>();

  // text field controller
  TextEditingController idC = TextEditingController();
  TextEditingController kodeC = TextEditingController();

  final jenisList = [
    'PLTB',
    'PLTS',
    'Diesel',
    'Baterai',
    'Weather Station',
    'Rumah Energi',
  ];

  final statusList = [
    'Aktif',
    'Tidak Aktif',
  ];

  late String selectedJenis = widget.currentJenis;
  late String selectedStatus = widget.currentStatus;

  @override
  void initState() {
    idC = TextEditingController(text: widget.currentId);
    kodeC = TextEditingController(text: widget.currentKode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
      body: Form(
        key: _editPerangkatKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Kode
                InputForm(
                  title: "Id",
                  controller: idC,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // Kode
                InputForm(
                  title: "Kode Perangkat",
                  controller: kodeC,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // jenis
                DropdownButtonFormField(
                  value: selectedJenis,
                  items: jenisList
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedJenis = val as String;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Jenis Perangkat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih Perangkat';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // status
                DropdownButtonFormField(
                  value: selectedStatus,
                  items: statusList
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedStatus = val as String;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Status Perangkat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih Status';
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
                      if (_editPerangkatKey.currentState!.validate()) {
                        await DatabaseService().updatePerangkat(
                          docClusterId: widget.docClusterId,
                          docPerangkatId: widget.docPerangkatId,
                          idPerangkat: idC.text,
                          kodePerangkat: kodeC.text,
                          jenisPerangkat: selectedJenis,
                          statusPerangkat: selectedStatus,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Perangkat Berhasil Diupdate'),
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
