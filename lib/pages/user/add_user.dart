import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final addUserKey = GlobalKey<FormState>();

  // text field controller
  TextEditingController emailC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController noHpC = TextEditingController();

  final roleList = [
    'Admin IT',
    'PLN (Pusat)',
    'PLN (Wilayah)',
    'PLN (Area)',
    'Admin PLN',
    'Kontraktor',
    'Vendor',
    'Admin Vendor',
    'Operator Vendor',
    'Gudang'
  ];
  String? selectedVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah User")),
      body: Form(
        key: addUserKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama
                InputForm(
                  title: "Nama",
                  controller: namaC,
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

                //email
                InputForm(
                  title: "Email",
                  controller: emailC,
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

                //noHp
                InputForm(
                  title: "noHp",
                  controller: noHpC,
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

                // role
                DropdownButtonFormField(
                  items: roleList
                      .map(
                        (e) => DropdownMenuItem(child: Text(e), value: e),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedVal = val as String;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih role user';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                //submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (addUserKey.currentState!.validate() &&
                          selectedVal != null) {
                        await DatabaseService().addUser(
                          email: emailC.text,
                          nama: namaC.text,
                          noHp: noHpC.text,
                          role: selectedVal,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Berhasil Ditambahkan'),
                          ),
                        );
                      } else {
                        const SnackBar(
                          content: Text('Gagal Menambahkan User '),
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
                        primary: const Color.fromARGB(225, 12, 144, 125)),
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
