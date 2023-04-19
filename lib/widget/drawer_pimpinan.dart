import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/pages/home/maps.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class DrawerPimpinan extends StatefulWidget {
  const DrawerPimpinan({Key? key}) : super(key: key);

  @override
  State<DrawerPimpinan> createState() => _DrawerPimpinanState();
}

class _DrawerPimpinanState extends State<DrawerPimpinan> {
  var currentPage = DrawerSectionsPemilik.home;
  var container;
  var title;

  @override
  Widget build(BuildContext context) {
    container;
    if (currentPage == DrawerSectionsPemilik.home) {
      container = const Maps();
    } else if (currentPage == DrawerSectionsPemilik.logout) {
      _logOut();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 18, 149, 117),
        elevation: 0,
        title: title,
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              drawerPimpinanList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerPimpinanList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Iconsax.home,
              currentPage == DrawerSectionsPemilik.home ? true : false),
          menuItem(2, "Logout", Iconsax.logout,
              currentPage == DrawerSectionsPemilik.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSectionsPemilik.home;
            } else if (id == 2) {
              currentPage = DrawerSectionsPemilik.logout;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  // size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSectionsPemilik { home, logout }

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
