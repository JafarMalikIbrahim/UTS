import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/asset.dart';
import 'package:manajemen_aset/pages/monitoring/monitoring_screen.dart';
import 'package:manajemen_aset/pages/report/report_screen.dart';

class ListP extends StatefulWidget {
  final String docClusterId;
  final String docPerangkatId;
  final String perangkatId;
  final String jenisPerangkat;
  final String kodePerangkat;
  const ListP({
    Key? key,
    required this.docClusterId,
    required this.docPerangkatId,
    required this.perangkatId,
    required this.jenisPerangkat,
    required this.kodePerangkat,
  }) : super(key: key);

  @override
  State<ListP> createState() => _ListPState();
}

class _ListPState extends State<ListP> with SingleTickerProviderStateMixin {
  // ScrollController? _scrollController;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 18, 149, 117),
        elevation: 0,
        title: Text(widget.kodePerangkat),
      ),
      body: ListView(
        children: [
          // Tab Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              indicator: const BubbleTabIndicator(
                indicatorHeight: 33,
                indicatorColor:Color.fromARGB(225, 18, 149, 117),
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                indicatorRadius: 30,
              ),
              labelPadding: const EdgeInsets.only(right: 15, left: 15),
              tabs: const [
                Tab(
                  child: Text(
                    'Asset',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    'Monitoring',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    'Report',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),

          // Tab View
          SizedBox(
            width: double.infinity,
            height: 600,
            child: TabBarView(
              controller: _tabController,
              children: [
                // list aset
                // BuilderAset(
                //   stream: DatabaseService().listAset(
                //     widget.docClusterId,
                //     widget.docPerangkatId,
                //   ),
                // ),
                ExpansionTileCardDemo(
                  idCluster: widget.docClusterId,
                  idPerangkat: widget.docPerangkatId,
                ),
                // pindah ke halaman untuk cek jenis aset
                MonitoringScreen(
                  jenisPerangkat: widget.jenisPerangkat,
                  idPerangkat: widget.perangkatId,
                ),
                // halaman report
                const ReportScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
