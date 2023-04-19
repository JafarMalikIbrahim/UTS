import 'package:latlong2/latlong.dart';

class Cluster {
  final String? nama;
  final LatLng? lokasi;
  Cluster({required this.nama, required this.lokasi});
}

class Perangkat {
  final String? kode;
  final String? jenisPerangkat;
  Perangkat({required this.kode, required this.jenisPerangkat});
}

final mapCluster = [
  Cluster(
    nama: "Cluster Tuban",
    lokasi: LatLng(-6.9066546, 112.162612),
  ),
  Cluster(
    nama: "Cluster Yensawai",
    lokasi: LatLng(-0.8346869, 130.5062881),
  ),
  Cluster(
    nama: "Cluster Kabare",
    lokasi: LatLng(-0.043687282791459, 131.00970926226),
  ),
  Cluster(
    nama: "Cluster Meos",
    lokasi: LatLng(-0.39318522293182, 130.25276892054),
  )
];
