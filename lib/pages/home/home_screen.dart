import 'package:flutter/material.dart';
import 'package:manajemen_aset/widget/status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hi, Admin",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Selamat Datang",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Image.asset("img/Wind turbine-pana.png", height: 130),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      shrinkWrap: true,
                      children: const [
                        StatusCard(
                            img: 'img/turbine.png',
                            title: '4',
                            subTitle: 'Total Cluster'),
                        StatusCard(
                            img: 'img/partly-cloudy.png',
                            title: '4',
                            subTitle: 'Total Aset'),
                        StatusCard(
                            img: 'img/solar-panel.png',
                            title: '4',
                            subTitle: 'Aset Aktif'),
                        StatusCard(
                            img: 'img/battery-charge.png',
                            title: '4',
                            subTitle: 'Aset Tidak Aktif'),
                        StatusCard(
                            img: 'img/solar-panel.png',
                            title: '4',
                            subTitle: 'Perbaikan'),
                        StatusCard(
                            img: 'img/battery-charge.png',
                            title: '4',
                            subTitle: 'Rusak'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget background() {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        color: Color.fromARGB(225, 18, 149, 117),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
