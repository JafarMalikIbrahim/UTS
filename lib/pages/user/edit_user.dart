import 'package:flutter/material.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class EditUser extends StatefulWidget {
  final String currentEmail;
  final String currentNama;
  final String currentRole;
  final String currentNoHp;

  const EditUser({
    Key? key,
    required this.currentEmail,
    required this.currentNama,
    required this.currentRole,
    required this.currentNoHp,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _editUserKey = GlobalKey<FormState>();

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
  ];
  late String selectedRole = widget.currentRole;

  @override
  void initState() {
    emailC = TextEditingController(text: widget.currentEmail);
    namaC = TextEditingController(text: widget.currentNama);
    noHpC = TextEditingController(text: widget.currentNoHp);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
      body: Form(
        key: _editUserKey,
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
                      return 'Please enter this section';
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
                      return 'Please enter this section';
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
                      selectedRole = val as String;
                    });
                  },
                  value: selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please choose this reading status';
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
                      // if (_editUserKey.currentState!.validate() &&
                      //     selectedRole != null) {
                      //   await createUser(
                      //     email: emailC.text,
                      //     nama: namaC.text,
                      //     role: selectedVal,
                      //   );
                      //   Navigator.of(context).pop();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('User Berhasil Ditambahkan'),
                      //     ),
                      //   );
                      // } else {
                      //   const SnackBar(
                      //     content: Text('Gagal Menambahkan User '),
                      //   );
                      // }
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
