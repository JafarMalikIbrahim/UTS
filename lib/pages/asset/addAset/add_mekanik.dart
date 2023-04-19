import 'dart:io';

import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';
import 'package:sqflite/sqflite.dart';

class AddMekanik extends StatefulWidget {
  final String perangkatId;
  final String clusterId;
  const AddMekanik(
      {Key? key, required this.clusterId, required this.perangkatId})
      : super(key: key);

  @override
  State<AddMekanik> createState() => _AddMekanikState();
}

class _AddMekanikState extends State<AddMekanik> {
  final _addMekanikKey = GlobalKey<FormState>();

  // SPD Wajib
  TextEditingController spd11C = TextEditingController();
  TextEditingController spd12C = TextEditingController();
  TextEditingController spd13C = TextEditingController();
  // SPD Opsional
  TextEditingController spd14C = TextEditingController();
  TextEditingController spd15C = TextEditingController();

  TextEditingController lokasiC = TextEditingController();
  TextEditingController tglPasangC = TextEditingController();
  TextEditingController idC = TextEditingController();

  List allTextField = [];

  DateTime? _dateTimeP;

  void _showDatePickerP() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTimeP = value!;
        tglPasangC.text = DateFormat('dd MMM yyyy').format(_dateTimeP!);
      });
    });
  }

  File? _pickedImage;
  File? _pickedImage2;

  Future openCamera() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image == null) return;
    File? img = File(image.path);
    setState(() {
      _pickedImage = img;
      // Navigator.of(context).pop();
    });
  }

  Future openCamera2() async {
    final image2 = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image2 == null) return;
    File? img2 = File(image2.path);
    setState(() {
      _pickedImage2 = img2;
      // Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    lokasiC.text = "Onsite"; //default text
    allTextField = [
      {
        // "label": "SPD 1.4",
        "value": spd14C,
        "text_field": InputForm(
          title: "SPD 1.4",
          controller: spd14C,
          prefixIcon: const Icon(Iconsax.document_text),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        // "label": "SPD 1.5",
        "value": spd15C,
        "text_field": InputForm(
          title: "SPD 1.5",
          controller: spd15C,
          prefixIcon: const Icon(Iconsax.document_text),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
    ];
  }

  List displayTextField = [];

  addTextField() {
    print("addTextField");

    setState(() {
      if (allTextField.length == displayTextField.length) {
        print("Same");
        return;
      } else {
        displayTextField.add(allTextField[displayTextField.length]);
      }
    });
  }

  removeTextField() {
    print("removeTextField");

    setState(() {
      if (displayTextField.isNotEmpty) {
        displayTextField.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SPD 1 (Mekanik)")),
      body: Theme(
        data: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.greenAccent,
          fontFamily: 'OpenSans',
        ),
        child: Form(
          key: _addMekanikKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SPD 1.1
                  InputForm(
                    title: "SPD 1.1",
                    controller: spd11C,
                    prefixIcon: Icon(Icons.text_snippet, color: Colors.green),
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

                  // SPD 1.2
                  InputForm(
                    title: "SPD 1.2",
                    controller: spd12C,
                    prefixIcon: Icon(Icons.text_snippet, color: Colors.green),
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

                  // SPD 1.3
                  InputForm(
                    title: "SPD 1.3",
                    controller: spd13C,
                    prefixIcon: Icon(Icons.text_snippet, color: Colors.green),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('SPD Tambahan :'),
                      ElevatedButton.icon(
                        onPressed: addTextField,
                        icon: Icon(Icons.add),
                        label: const Text('Tambah'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: const Color.fromARGB(225, 12, 144, 125),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: removeTextField,
                        icon: Icon(Icons.remove),
                        label: const Text('Hapus'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: const Color.fromARGB(255, 151, 158, 157),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  ...displayTextField
                      .map(
                        (e) => Column(
                          children: [
                            e['text_field'],
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )
                      .toList(),

                  // lokasi Asset
                  NonEditableForm(
                    title: "Lokasi Asset",
                    controller: lokasiC,
                    prefixIcon:
                        const Icon(Iconsax.document_text, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Tanggal dipasang
                  TextFormField(
                    autofocus: true,
                    controller: tglPasangC,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Dipasang',
                      prefixIcon:
                          const Icon(Iconsax.calendar_1, color: Colors.green),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Pilih Tanggal',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Wajib Diisi';
                      }
                      return null;
                    },
                    onTap: () {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(FocusNode());
                      _showDatePickerP();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Foto 1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "(aset barang terlihat keseluruhan)",
                            style: TextStyle(fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () {
                              openCamera();
                            },
                            child: Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.19,
                                width: MediaQuery.of(context).size.width * 0.80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: _pickedImage == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Iconsax.camera),
                                            Text('Add Foto')
                                          ],
                                        )
                                      : ClipRect(
                                          child: Image(
                                            image: FileImage(_pickedImage!),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Tindakan ketika tombol edit ditekan
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Tindakan ketika tombol hapus ditekan
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // foto 2
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Foto 2",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "(dimensi barang nampak dg alat ukur/penggaris)",
                            style: TextStyle(fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () {
                              openCamera2();
                            },
                            child: Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.19,
                                width: MediaQuery.of(context).size.width * 0.80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: _pickedImage2 == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Iconsax.camera),
                                            Text('Add Foto')
                                          ],
                                        )
                                      : ClipRect(
                                          child: Image(
                                            image: FileImage(_pickedImage2!),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Tindakan ketika tombol edit ditekan
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Tindakan ketika tombol hapus ditekan
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(
                        16.0), // atau EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
                  ),

                  //submit button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_addMekanikKey.currentState!.validate() &&
                            _pickedImage != null) {
                          await DatabaseService().addMekanik(
                            id: '0',
                            spd11: spd11C.text,
                            spd12: spd12C.text,
                            spd13: spd13C.text,
                            spd14: spd14C.text,
                            spd15: spd15C.text,
                            lokasi: lokasiC.text,
                            tglPasang: tglPasangC.text,
                            img1: _pickedImage,
                            img2: _pickedImage2,
                            idPerangkat: widget.perangkatId,
                            idCluster: widget.clusterId,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Asset Berhasil Tersimpan'),
                            ),
                          );
                        } else if (_pickedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill image'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save),
                          Text(
                            "Simpan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: const Color.fromARGB(225, 12, 144, 125),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
