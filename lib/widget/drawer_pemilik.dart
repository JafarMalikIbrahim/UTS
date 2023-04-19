import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/home/maps.dart';
import 'package:manajemen_aset/pages/location/location_screen.dart';
import 'package:manajemen_aset/pages/monitoring/wt_realtime.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class DrawerPemilik extends StatefulWidget {
  const DrawerPemilik({Key? key}) : super(key: key);

  @override
  State<DrawerPemilik> createState() => _DrawerPemilikState();
}

class _DrawerPemilikState extends State<DrawerPemilik> {
  var currentPage = DrawerSectionsPemilik.home;
  var container;
  var title;

  @override
  Widget build(BuildContext context) {
    container;
    if (currentPage == DrawerSectionsPemilik.home) {
      container = const Maps();
    } else if (currentPage == DrawerSectionsPemilik.asset) {
      // container = const AssetList();
      title = const Text('Aset');
    } else if (currentPage == DrawerSectionsPemilik.monitoringEnergy) {
      // container = const MonitoringWtScreen();
      // container = const AssetList();
      title = const Text("Monitoring");
    } else if (currentPage == DrawerSectionsPemilik.monitoringWs) {
      // container = const MonitoringScreen();
      title = const Text("Monitoring");
    } else if (currentPage == DrawerSectionsPemilik.realtimeWt) {
      container = const WtRealtime();
      title = const Text("Realtime Wind Turbine");
    } else if (currentPage == DrawerSectionsPemilik.laporan) {
      // container = const LaporanScreen();
      title = const Text('Laporan');
    } else if (currentPage == DrawerSectionsPemilik.rekomendasi) {
      container = const LocationScreen();
      title = const Text('Rekomendasi Perbaikan Aset');
    } else if (currentPage == DrawerSectionsPemilik.logout) {
      _logOut();
    } else if (currentPage == DrawerSectionsPemilik.perangkat) {
      // container = const ListPerangkat();
      title = const Text('Rekomendasi Perbaikan Aset');
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
              drawerPemilikList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerPemilikList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSectionsPemilik.home ? true : false),
          menuItem(2, "Asset", Icons.inventory,
              currentPage == DrawerSectionsPemilik.asset ? true : false),
          menuItem(
              3,
              "Monitoring Energy",
              Icons.stacked_line_chart_outlined,
              currentPage == DrawerSectionsPemilik.monitoringEnergy
                  ? true
                  : false),
          menuItem(4, "Monitoring WS", Icons.stacked_line_chart_outlined,
              currentPage == DrawerSectionsPemilik.monitoringWs ? true : false),
          menuItem(5, "Realtime WT", Icons.check_box,
              currentPage == DrawerSectionsPemilik.realtimeWt ? true : false),
          menuItem(6, "Laporan", Icons.description,
              currentPage == DrawerSectionsPemilik.laporan ? true : false),
          menuItem(7, "Rekomendasi Perbaikan Aset", Icons.error,
              currentPage == DrawerSectionsPemilik.rekomendasi ? true : false),
          const Divider(),
          menuItem(8, "Logout", Icons.logout,
              currentPage == DrawerSectionsPemilik.logout ? true : false),
          menuItem(9, "Perangkat", Icons.logout,
              currentPage == DrawerSectionsPemilik.perangkat ? true : false),
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
              currentPage = DrawerSectionsPemilik.asset;
            } else if (id == 3) {
              currentPage = DrawerSectionsPemilik.monitoringEnergy;
            } else if (id == 4) {
              currentPage = DrawerSectionsPemilik.monitoringWs;
            } else if (id == 5) {
              currentPage = DrawerSectionsPemilik.realtimeWt;
            } else if (id == 6) {
              currentPage = DrawerSectionsPemilik.laporan;
            } else if (id == 7) {
              currentPage = DrawerSectionsPemilik.rekomendasi;
            } else if (id == 8) {
              currentPage = DrawerSectionsPemilik.logout;
            } else if (id == 9) {
              currentPage = DrawerSectionsPemilik.perangkat;
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

enum DrawerSectionsPemilik {
  home,
  asset,
  monitoringEnergy,
  monitoringWs,
  realtimeWt,
  laporan,
  rekomendasi,
  logout,
  perangkat,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
