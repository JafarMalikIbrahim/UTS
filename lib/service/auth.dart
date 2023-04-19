import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/login/login_screen.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/drawer_admin_it.dart';
import 'package:manajemen_aset/widget/drawer_kontraktor.dart';
import 'package:manajemen_aset/widget/drawer_pimpinan.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Widget homePageManager = const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: DatabaseService().userRole(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snap.hasData) {
            String? role = snap.data?.data()?['role'];
            if (role == 'Admin IT') {
              return const DrawerAdminIT();
            } else if (role == 'PLN (Pusat)') {
              return const DrawerPimpinan();
            } else if (role == 'PLN (Wilayah)') {
              return const DrawerPimpinan();
            } else if (role == 'PLN (Area)') {
              return const DrawerPimpinan();
            } else if (role == 'Admin PLN') {
              return const DrawerPimpinan();
            } else if (role == 'Kontraktor') {
              return const DrawerKontraktor();
            } else if (role == 'Vendor') {
              return const DrawerPimpinan();
            } else if (role == 'Admin Vendor') {
              return const DrawerPimpinan();
            } else if (role == 'Operator Vendor') {
              return const DrawerPimpinan();
            } else if (role == 'Gudang') {
              // return const DrawerGudang();
            } else {
              return const LoginScreen();
            }
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
