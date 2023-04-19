import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class AddAset extends StatefulWidget {
  // final String docId;
  const AddAset({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAset> createState() => _AddAsetState();
}

class _AddAsetState extends State<AddAset> {
  final _addAsetKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ExpansionTileCardState> cardMekanik = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardElektrik = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardKd = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardSensor = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardIt = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardSipil = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah")),
      body: Form(
        key: _addAsetKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // mekanik
                ExpansionTileCard(
                  leading: CircleAvatar(
                    child: Image.asset("img/mekanik.png"),
                    backgroundColor: Colors.blueGrey,
                  ),
                  baseColor: const Color.fromARGB(223, 212, 221, 218),
                  expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
                  // expandedColor: Colors.red[50],
                  key: cardMekanik,
                  title: const Text('Mekanik'),
                  subtitle: const Text('Deskripsi'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Data belum terisi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const AddMekanik(),
                                  //   ),
                                  // );
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
                const SizedBox(
                  height: 16,
                ),

                // elektrik
                ExpansionTileCard(
                  leading: CircleAvatar(
                    child: Image.asset("img/elektrik.png"),
                    backgroundColor: Colors.blueGrey,
                  ),
                  baseColor: const Color.fromARGB(223, 212, 221, 218),
                  expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
                  // expandedColor: Colors.red[50],
                  key: cardElektrik,
                  title: const Text('Elektrik'),
                  subtitle: const Text('Deskripsi'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Data belum terisi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const AddElektrik(),
                                  //   ),
                                  // );
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
                const SizedBox(
                  height: 16,
                ),

                // komunikasi data
                ExpansionTileCard(
                  leading: CircleAvatar(
                    child: Image.asset("img/mekanik.png"),
                    backgroundColor: Colors.blueGrey,
                  ),
                  baseColor: const Color.fromARGB(223, 212, 221, 218),
                  expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
                  // expandedColor: Colors.red[50],
                  key: cardKd,
                  title: const Text('Komunikasi Data'),
                  subtitle: const Text('Deskripsi'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Data belum terisi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const AddKd(),
                                  //   ),
                                  // );
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
                const SizedBox(
                  height: 16,
                ),

                // Sensor
                ExpansionTileCard(
                  leading: CircleAvatar(
                    child: Image.asset("img/sensor.png"),
                    backgroundColor: Colors.blueGrey,
                  ),
                  baseColor: const Color.fromARGB(223, 212, 221, 218),
                  expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
                  // expandedColor: Colors.red[50],
                  key: cardSensor,
                  title: const Text('Sensor'),
                  subtitle: const Text('Deskripsi'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Data belum terisi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const AddSensor(),
                                  //   ),
                                  // );
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
                const SizedBox(
                  height: 16,
                ),

                // IT
                ExpansionTileCard(
                  leading: CircleAvatar(
                    child: Image.asset("img/jaringan.png"),
                    backgroundColor: Colors.blueGrey,
                  ),
                  baseColor: const Color.fromARGB(223, 212, 221, 218),
                  expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
                  // expandedColor: Colors.red[50],
                  key: cardIt,
                  title: const Text('Information Technology'),
                  subtitle: const Text('Deskripsi'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Data belum terisi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const AddIt(),
                                  //   ),
                                  // );
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
                const SizedBox(
                  height: 16,
                ),

                // Sipil
                ExpansionTileCard(
                  leading: CircleAvatar(
                    child: Image.asset("img/mekanik.png"),
                    backgroundColor: Colors.blueGrey,
                  ),
                  baseColor: const Color.fromARGB(223, 212, 221, 218),
                  expandedTextColor: const Color.fromARGB(225, 18, 149, 117),
                  // expandedColor: Colors.red[50],
                  key: cardSipil,
                  title: const Text('Sipil'),
                  subtitle: const Text('Deskripsi'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Data belum terisi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const AddSipil(),
                                  //   ),
                                  // );
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
                const SizedBox(
                  height: 16,
                ),

                //submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // if (_addAssetKey.currentState!.validate()) {
                      //   await DatabaseService().addCluster(nama: clusterC.text);

                      //   Navigator.pop(context);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Data Cluster Berhasil ditambahkan'),
                      //     ),
                      //   );
                      // }
                    },
                    child: const Text(
                      "Sinkronisasi Data",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: const Color.fromARGB(225, 18, 149, 117),
                    ),
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
