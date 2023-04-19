import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/cluster/cluster_list_page.dart';
import 'package:manajemen_aset/pages/home/home_screen.dart';
import 'package:manajemen_aset/pages/perangkat/perangkat_list_page.dart';
import 'package:manajemen_aset/pages/user/user_list_page.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class DrawerKontraktor extends StatefulWidget {
  const DrawerKontraktor({Key? key}) : super(key: key);

  @override
  State<DrawerKontraktor> createState() => _DrawerKontraktorState();
}

class _DrawerKontraktorState extends State<DrawerKontraktor> {
  var currentPage = DrawerSectionsKontraktor.home;
  var container;
  var title;

  @override
  Widget build(BuildContext context) {
    title;
    container;
    if (currentPage == DrawerSectionsKontraktor.home) {
      container = const HomeScreen();
      // title = const Text("Beranda");
    } else if (currentPage == DrawerSectionsKontraktor.perangkat) {
      // docClusterId seharusnya otomatis mendapatkan data nya sesuai dengan wilayah tanggung jawab dari user
      container = const ListPerangkat(
        docClusterId: 'dp6bG3HKfkkKDQMu1EJO',
      );
      // title = const Text("Perangkat");
    } else if (currentPage == DrawerSectionsKontraktor.logout) {
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
              drawerKontraktor(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerKontraktor() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSectionsKontraktor.home ? true : false),
          menuItem(2, "Perangkat", Icons.people,
              currentPage == DrawerSectionsKontraktor.perangkat ? true : false),
          menuItem(3, "Logout", Icons.exit_to_app,
              currentPage == DrawerSectionsKontraktor.logout ? true : false),
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
              currentPage = DrawerSectionsKontraktor.home;
            } else if (id == 2) {
              currentPage = DrawerSectionsKontraktor.perangkat;
            } else if (id == 3) {
              currentPage = DrawerSectionsKontraktor.logout;
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

enum DrawerSectionsKontraktor {
  home,
  perangkat,
  logout,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
