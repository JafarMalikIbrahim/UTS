import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddPerangkat extends StatefulWidget {
  final String docId;
  const AddPerangkat({Key? key, required this.docId}) : super(key: key);

  @override
  State<AddPerangkat> createState() => _AddPerangkatState();
}

class _AddPerangkatState extends State<AddPerangkat> {
  final _addPerangkatKey = GlobalKey<FormState>();

  // text field controller
  final TextEditingController idC = TextEditingController();
  final TextEditingController kodeC = TextEditingController();

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
  String? selectedJenis = '';
  String? selectedStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Perangkat")),
      body: Form(
        key: _addPerangkatKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Kode
                // InputForm(
                //   title: "Id",
                //   controller: idC,
                //   validator: (val) {
                //     if (val!.isEmpty) {
                //       return 'Wajib diisi';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(
                //   height: 16,
                // ),

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
                // DropdownButtonFormField(
                //   items: statusList
                //       .map((e) => DropdownMenuItem(child: Text(e), value: e))
                //       .toList(),
                //   onChanged: (val) {
                //     setState(() {
                //       selectedStatus = val as String;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: 'Status Perangkat',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null) {
                //       return 'Pilih Status';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(
                //   height: 16,
                // ),

                //submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_addPerangkatKey.currentState!.validate()) {
                        await DatabaseService().addPerangkat(
                          documentId: widget.docId,
                          // idPerangkat: idC.text,
                          idPerangkat: '0',
                          kodePerangkat: kodeC.text,
                          jenisPerangkat: selectedJenis,
                          statusPerangkat: 'kosong',
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Data Perangkat Berhasil ditambahkan'),
                          ),
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
