import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_It.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_elektrik.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_kd.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_mekanik.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_sensor.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_sipil.dart';
import 'package:manajemen_aset/service/database.dart';

class ExpansionTileCardDemo extends StatefulWidget {
  final String idCluster;
  final String idPerangkat;
  const ExpansionTileCardDemo(
      {Key? key, required this.idCluster, required this.idPerangkat})
      : super(key: key);

  @override
  _ExpansionTileCardDemoState createState() => _ExpansionTileCardDemoState();
}

class _ExpansionTileCardDemoState extends State<ExpansionTileCardDemo> {
  final GlobalKey<ExpansionTileCardState> cardMekanik = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardElektrik = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardKd = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardSensor = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardIt = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardSipil = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // mekanik
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            leading: CircleAvatar(
              child: Image.asset("img/mekanik.png"),
              backgroundColor: Colors.blueGrey,
            ),
            baseColor: const Color.fromARGB(223, 212, 221, 218),
            expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
            key: cardMekanik,
            title: const Text('Mekanik'),
            subtitle: const Text('Deskripsi'),
            children: [
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .listMekanik(widget.idCluster, widget.idPerangkat),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String mekanikId =
                              snapshot.data!.docs[index].id;
                          // String id = documentSnapshot['id'] ?? "-";
                          String spd11 = documentSnapshot['spd11'] ?? "-";
                          String spd12 = documentSnapshot['spd12'] ?? "-";
                          String spd13 = documentSnapshot['spd13'] ?? "-";
                          String spd14 = documentSnapshot['spd14'] ?? "-";
                          String spd15 = documentSnapshot['spd15'] ?? "-";
                          String lokasi = documentSnapshot['lokasi'] ?? "-";
                          String tglPasang =
                              documentSnapshot['tglPasang'] ?? "-";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SPD 1.1: $spd11'),
                                Text('SPD 1.2: $spd12'),
                                Text('SPD 1.3: $spd13'),
                                Text('SPD 1.4: $spd14'),
                                Text('SPD 1.5: $spd15'),
                                Text('Tanggal Pasang: $tglPasang'),
                                const Divider(thickness: 1)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      cardMekanik.currentState?.expand();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddMekanik(
                                  clusterId: widget.idCluster,
                                  perangkatId: widget.idPerangkat,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // elektrik
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            leading: CircleAvatar(
              child: Image.asset("img/elektrik.png"),
              backgroundColor: Colors.blueGrey,
            ),
            baseColor: const Color.fromARGB(223, 212, 221, 218),
            expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
            key: cardElektrik,
            title: const Text('Elektrik'),
            subtitle: const Text('Elektrik'),
            children: [
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .listElektrik(widget.idCluster, widget.idPerangkat),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String elektrikId =
                              snapshot.data!.docs[index].id;
                          String id = documentSnapshot['id'];
                          String spd21 = documentSnapshot['spd21'] ?? "-";
                          String spd22 = documentSnapshot['spd22'] ?? "-";
                          String spd23 = documentSnapshot['spd23'] ?? "-";
                          String spd24 = documentSnapshot['spd24'] ?? "-";
                          String spd25 = documentSnapshot['spd25'] ?? "-";
                          String lokasi = documentSnapshot['lokasi'] ?? "-";
                          String tglPasang =
                              documentSnapshot['tglPasang'] ?? "-";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SPD 2.1: $spd21'),
                                Text('SPD 2.2: $spd22'),
                                Text('SPD 2.3: $spd23'),
                                Text('SPD 2.4: $spd24'),
                                Text('SPD 2.5: $spd25'),
                                Text('Tanggal Pasang: $tglPasang'),
                                const Divider(thickness: 1)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      cardMekanik.currentState?.expand();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddElektrik(
                                  clusterId: widget.idCluster,
                                  perangkatId: widget.idPerangkat,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // komunikasi data
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            leading: CircleAvatar(
              child: Image.asset("img/mekanik.png"),
              backgroundColor: Colors.blueGrey,
            ),
            baseColor: const Color.fromARGB(223, 212, 221, 218),
            expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
            key: cardKd,
            title: const Text('Komunikasi Data'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .listKd(widget.idCluster, widget.idPerangkat),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String mekanikId =
                              snapshot.data!.docs[index].id;
                          String id = documentSnapshot['id'];
                          String spd31 = documentSnapshot['spd31'] ?? "-";
                          String spd32 = documentSnapshot['spd32'] ?? "-";
                          String spd33 = documentSnapshot['spd33'] ?? "-";
                          String spd34 = documentSnapshot['spd34'] ?? "-";
                          String spd35 = documentSnapshot['spd35'] ?? "-";
                          String lokasi = documentSnapshot['lokasi'] ?? "-";
                          String tglPasang =
                              documentSnapshot['tglPasang'] ?? "-";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SPD 3.1: $spd31'),
                                Text('SPD 3.2: $spd32'),
                                Text('SPD 3.3: $spd33'),
                                Text('SPD 3.4: $spd34'),
                                Text('SPD 3.5: $spd35'),
                                Text('Tanggal Pasang: $tglPasang'),
                                const Divider(thickness: 1)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      cardMekanik.currentState?.expand();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddKd(
                                  clusterId: widget.idCluster,
                                  perangkatId: widget.idPerangkat,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // sensor
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            leading: CircleAvatar(
              child: Image.asset("img/sensor.png"),
              backgroundColor: Colors.blueGrey,
            ),
            baseColor: const Color.fromARGB(223, 212, 221, 218),
            expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
            key: cardSensor,
            title: const Text('Sensor'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .listSensor(widget.idCluster, widget.idPerangkat),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String sensorId = snapshot.data!.docs[index].id;
                          String id = documentSnapshot['id'];
                          String spd41 = documentSnapshot['spd41'] ?? "-";
                          String spd42 = documentSnapshot['spd42'] ?? "-";
                          String spd43 = documentSnapshot['spd43'] ?? "-";
                          String spd44 = documentSnapshot['spd44'] ?? "-";
                          String spd45 = documentSnapshot['spd45'] ?? "-";
                          String lokasi = documentSnapshot['lokasi'] ?? "-";
                          String tglPasang =
                              documentSnapshot['tglPasang'] ?? "-";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SPD 4.1: $spd41'),
                                Text('SPD 4.2: $spd42'),
                                Text('SPD 4.3: $spd43'),
                                Text('SPD 4.4: $spd44'),
                                Text('SPD 4.5: $spd45'),
                                Text('Tanggal Pasang: $tglPasang'),
                                const Divider(thickness: 1)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      cardMekanik.currentState?.expand();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSensor(
                                  clusterId: widget.idCluster,
                                  perangkatId: widget.idPerangkat,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // IT
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            leading: CircleAvatar(
              child: Image.asset("img/jaringan.png"),
              backgroundColor: Colors.blueGrey,
            ),
            baseColor: const Color.fromARGB(223, 212, 221, 218),
            expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
            key: cardIt,
            title: const Text('Information Technology'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .listIt(widget.idCluster, widget.idPerangkat),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String mekanikId =
                              snapshot.data!.docs[index].id;
                          String id = documentSnapshot['id'];
                          String spd51 = documentSnapshot['spd51'] ?? "-";
                          String spd52 = documentSnapshot['spd52'] ?? "-";
                          String spd53 = documentSnapshot['spd53'] ?? "-";
                          String spd54 = documentSnapshot['spd54'] ?? "-";
                          String spd55 = documentSnapshot['spd55'] ?? "-";
                          String lokasi = documentSnapshot['lokasi'] ?? "-";
                          String tglPasang =
                              documentSnapshot['tglPasang'] ?? "-";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SPD 5.1: $spd51'),
                                Text('SPD 5.2: $spd52'),
                                Text('SPD 5.3: $spd53'),
                                Text('SPD 5.4: $spd54'),
                                Text('SPD 5.5: $spd55'),
                                Text('Tanggal Pasang: $tglPasang'),
                                const Divider(thickness: 1)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      cardMekanik.currentState?.expand();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddIt(
                                  clusterId: widget.idCluster,
                                  perangkatId: widget.idPerangkat,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // sipil
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            leading: CircleAvatar(
              child: Image.asset("img/mekanik.png"),
              backgroundColor: Colors.blueGrey,
            ),
            baseColor: const Color.fromARGB(223, 212, 221, 218),
            expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
            key: cardSipil,
            title: const Text('Sipil'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .listSipil(widget.idCluster, widget.idPerangkat),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final documentSnapshot = snapshot.data!.docs[index];
                          final String mekanikId =
                              snapshot.data!.docs[index].id;
                          String id = documentSnapshot['id'];
                          String spd61 = documentSnapshot['spd61'] ?? "-";
                          String spd62 = documentSnapshot['spd62'] ?? "-";
                          String spd63 = documentSnapshot['spd63'] ?? "-";
                          String spd64 = documentSnapshot['spd64'] ?? "-";
                          String spd65 = documentSnapshot['spd65'] ?? "-";
                          String lokasi = documentSnapshot['lokasi'] ?? "-";
                          String tglPasang =
                              documentSnapshot['tglPasang'] ?? "-";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SPD 1.1: $spd61'),
                                Text('SPD 1.2: $spd62'),
                                Text('SPD 1.3: $spd63'),
                                Text('SPD 1.4: $spd64'),
                                Text('SPD 1.5: $spd65'),
                                Text('Tanggal Pasang: $tglPasang'),
                                const Divider(thickness: 1)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      cardMekanik.currentState?.expand();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSipil(
                                  clusterId: widget.idCluster,
                                  perangkatId: widget.idPerangkat,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
