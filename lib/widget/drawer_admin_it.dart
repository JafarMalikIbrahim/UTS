import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/pages/cluster/cluster_list_page.dart';
import 'package:manajemen_aset/pages/home/home_screen.dart';
import 'package:manajemen_aset/pages/user/user_list_page.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class DrawerAdminIT extends StatefulWidget {
  const DrawerAdminIT({Key? key}) : super(key: key);

  @override
  State<DrawerAdminIT> createState() => _DrawerAdminITState();
}

class _DrawerAdminITState extends State<DrawerAdminIT> {
  var currentPage = DrawerSectionsAdmin.home;
  var container;
  var title;

  @override
  Widget build(BuildContext context) {
    title;
    container;
    if (currentPage == DrawerSectionsAdmin.home) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSectionsAdmin.users) {
      container = const UserList();
      title = const Text("User");
    } else if (currentPage == DrawerSectionsAdmin.cluster) {
      container = const ClusterList();
      title = const Text("Cluster");
    } else if (currentPage == DrawerSectionsAdmin.logout) {
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
              drawerAdminIT(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerAdminIT() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Iconsax.home,
              currentPage == DrawerSectionsAdmin.home ? true : false),
          menuItem(2, "User", Icons.people,
              currentPage == DrawerSectionsAdmin.users ? true : false),
          menuItem(3, "Cluster", Icons.map,
              currentPage == DrawerSectionsAdmin.cluster ? true : false),
          menuItem(4, "Logout", Icons.exit_to_app,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
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
              currentPage = DrawerSectionsAdmin.home;
            } else if (id == 2) {
              currentPage = DrawerSectionsAdmin.users;
            } else if (id == 3) {
              currentPage = DrawerSectionsAdmin.cluster;
            } else if (id == 4) {
              currentPage = DrawerSectionsAdmin.logout;
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

enum DrawerSectionsAdmin {
  home,
  users,
  cluster,
  logout,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
