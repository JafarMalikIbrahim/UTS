import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:manajemen_aset/pages/home/bottom_sheet.dart';
import 'package:geolocator/geolocator.dart' as geo;

class Maps extends StatefulWidget {
  final docClusterId;
  const Maps({Key? key, this.docClusterId}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> with TickerProviderStateMixin {
  var currentLocation = LatLng(-0.789275, 113.921327);
  List<Marker> markers = [];

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    getMarkers();
  }

  // get data cluster
  Future<void> getMarkers() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('cluster').get();
    snapshot.docs.forEach((doc) {
      String documentId = doc.id;
      String idCluster = doc['id'];
      String namaCluster = doc['nama'];
      GeoPoint geoPoint = doc['lokasi'];
      double lat = geoPoint.latitude;
      double lng = geoPoint.longitude;
      setState(() {
        markers.add(
          Marker(
            height: 40,
            width: 40,
            point: LatLng(lat, lng),
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.wind_power,
                color: Colors.indigo,
              ),
              onPressed: () {
                showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: BottomSheetMap(
                        namaCluster: namaCluster,
                        idCluster: idCluster,
                        documentId: documentId,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      });
    });
  }

  // fungsi untuk mendapatkan lokasi terkini
  void _getCurrentLocation() async {
    try {
      // Request permission to access the location
      final permission = await geo.Geolocator.requestPermission();

      if (permission == geo.LocationPermission.denied) {
        // Permission was denied, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission denied'),
          ),
        );
        return;
      }

      // Get the current position
      final position = await geo.Geolocator.getCurrentPosition();

      // Update the map controller to center on the current position
      mapController.move(LatLng(position.latitude, position.longitude), 8);

      // Update the state to trigger a rebuild
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        markers.add(
          Marker(
            height: 40,
            width: 40,
            point: currentLocation,
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Lokasi Terkini"),
                      content: Text(
                          "${currentLocation.latitude}, ${currentLocation.longitude}"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get the current location'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              center: currentLocation,
              zoom: 4.4,
              // disable rotation
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            layers: [
              TileLayerOptions(
                minZoom: 1,
                maxZoom: 18,
                backgroundColor: Colors.black,
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: markers,
              ),
            ],
          ),
          // tombol lokasi terkini
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: _getCurrentLocation,
                tooltip: 'Current Location',
                child: const Icon(
                  Iconsax.gps,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
