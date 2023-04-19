import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference clusterCollection =
      FirebaseFirestore.instance.collection('cluster');
  final CollectionReference perangkatCollection =
      FirebaseFirestore.instance.collection('perangkat');
  final CollectionReference asetCollection =
      FirebaseFirestore.instance.collection('aset');
  final CollectionReference pengecekanCollection =
      FirebaseFirestore.instance.collection('pengecekan');
  final CollectionReference perbaikanCollection =
      FirebaseFirestore.instance.collection('perbaikan');
  final CollectionReference perawatanCollection =
      FirebaseFirestore.instance.collection('perawatan');

// USER
  // menambahkan user
  Future<void> addUser({
    String? email,
    String? nama,
    String? role,
    String? noHp,
  }) async {
    if (email!.isNotEmpty && nama!.isNotEmpty) {
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: "12345678");
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await firestore.collection("user").doc(uid).set({
            "nama": nama,
            "email": email,
            "uid": uid,
            "noHp": noHp,
            "role": role,
            "createdAt": DateTime.now().toIso8601String()
          });
        }
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          const SnackBar(
              content: Text("Password yang digunakan terlalu singkat"));
        } else if (e.code == 'email-already-in-use') {
          const SnackBar(content: Text("User telah terdaftar"));
        }
      } catch (e) {
        const SnackBar(content: Text("Tidak dapat menambahkan user"));
      }
    } else {
      const SnackBar(content: Text("Email dan nama harus terisi"));
    }
  }

  // menampilkan list user
  Stream<QuerySnapshot> listUser() {
    return userCollection.orderBy('nama').snapshots();
  }

  // user role
  Stream<DocumentSnapshot<Map<String, dynamic>>> userRole() async* {
    String? uid = auth.currentUser?.uid;
    yield* firestore.collection("user").doc(uid).snapshots();
  }

// CLUSTER
  // menambahkan cluster
  Future<void> addCluster({
    String? id,
    String? nama,
    required double lat,
    required double lng,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "nama": nama,
      "lokasi": GeoPoint(lat, lng)
    };
    await docReferencer
        .set(data)
        .whenComplete(() => print("Data cluster berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // menampilkan list cluster
  Stream<QuerySnapshot> listCluster() {
    return clusterCollection.snapshots();
  }

  // edit cluster
  Future<void> updateCluster({
    String? documentId,
    String? id,
    String? nama,
    required double lat,
    required double lng,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc(documentId);
    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "nama": nama,
      "lokasi": GeoPoint(lat, lng)
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Data cluster berhasil diupdate"))
        .catchError((e) => print(e));
  }

  // hapus cluster
  Future<void> deleteCluster({
    String? documentId,
  }) async {
    DocumentReference docReferencer = clusterCollection.doc(documentId);
    await docReferencer
        .delete()
        .whenComplete(() => print('Data cluster berhasil dihapus'))
        .catchError((e) => print(e));
  }

// PERANGKAT
  // menambahkan perangkat
  Future<void> addPerangkat({
    String? documentId,
    String? idPerangkat,
    String? kodePerangkat,
    String? jenisPerangkat,
    String? statusPerangkat,
  }) async {
    DocumentReference docReferencer =
        clusterCollection.doc(documentId).collection('perangkat').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "id": idPerangkat,
      "kode": kodePerangkat,
      "jenis": jenisPerangkat,
      "status": statusPerangkat
    };
    await docReferencer
        .set(data)
        .whenComplete(() => print("Data perangkat berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // menampilkan list perangkat
  Stream<QuerySnapshot> listPerangkat(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.snapshots();
  }

  // menampilkan list perangkat pltb
  Stream<QuerySnapshot> listPerangkatWT(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'PLTB').snapshots();
  }

  // menampilkan list perangkat plts
  Stream<QuerySnapshot> listPerangkatSP(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'PLTS').snapshots();
  }

  // menampilkan list perangkat diesel
  Stream<QuerySnapshot> listPerangkatDS(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'Diesel').snapshots();
  }

  // menampilkan list perangkat batery
  Stream<QuerySnapshot> listPerangkatBT(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection.where('jenis', isEqualTo: 'Baterai').snapshots();
  }

  // menampilkan list perangkat weather station
  Stream<QuerySnapshot> listPerangkatWS(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection
        .where('jenis', isEqualTo: 'Weather Station')
        .snapshots();
  }

  // menampilkan list perangkat rumah energi
  Stream<QuerySnapshot> listPerangkatRE(String idCluster) {
    CollectionReference perangkatCollection =
        clusterCollection.doc(idCluster).collection('perangkat');
    return perangkatCollection
        .where('jenis', isEqualTo: 'Rumah Energi')
        .snapshots();
  }

  // edit perangkat
  Future<void> updatePerangkat({
    String? docClusterId,
    String? docPerangkatId,
    String? idPerangkat,
    String? kodePerangkat,
    String? jenisPerangkat,
    String? statusPerangkat,
  }) async {
    DocumentReference docReferencer = clusterCollection
        .doc(docClusterId)
        .collection('perangkat')
        .doc(docPerangkatId);
    Map<String, dynamic> data = <String, dynamic>{
      "id": idPerangkat,
      "kode": kodePerangkat,
      "jenis": jenisPerangkat,
      "status": statusPerangkat
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Data cluster berhasil diupdate"))
        .catchError((e) => print(e));
  }

  // hapus perangkat
  Future<void> deletePerangkat({
    String? docPerangkatId,
    String? docClusterId,
  }) async {
    DocumentReference docReferencer = clusterCollection
        .doc(docClusterId)
        .collection('perangkat')
        .doc(docPerangkatId);
    await docReferencer
        .delete()
        .whenComplete(() => print('Data perangkat berhasil dihapus'))
        .catchError((e) => print(e));
  }

// ASSET GUDANG
  // menambahkan asset gudang
  Future<void> addAssetGudang({
    String? documentId,
    // String? kodeAssetGudang,
    String? jenisAset,
    String? spd11,
    String? spd12,
    String? spd13,
    String? spd21,
    String? spd31,
    String? spd41,
    String? spd42,
    String? spd51,
    String? lokasi,
    String? kondisi,
    String? tglDiterima,
  }) async {
    DocumentReference docReferencer =
        clusterCollection.doc(documentId).collection('gudang').doc();
    Map<String, dynamic> data = <String, dynamic>{
      // "kode": kodeAssetGudang,
      "jenis": jenisAset,
      "spd11": spd11,
      "spd12": spd12,
      "spd13": spd13,
      "spd21": spd21,
      "spd31": spd31,
      "spd41": spd41,
      "spd42": spd42,
      "spd51": spd51,
      "lokasi": lokasi,
      "kondisi": kondisi,
      "tglDiterima": tglDiterima,
    };
    await docReferencer
        .set(data)
        .whenComplete(() => print("Data perangkat berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // // menampilkan list perangkat mekanik
  // Stream<QuerySnapshot> listMekanik(String idCluster) {
  //   CollectionReference gudangCollection =
  //       clusterCollection.doc(idCluster).collection('gudang');
  //   return gudangCollection.where('jenis', isEqualTo: 'Mekanik').snapshots();
  // }

  // // menampilkan list perangkat elektrik
  // Stream<QuerySnapshot> listElektrik(String idCluster) {
  //   CollectionReference gudangCollection =
  //       clusterCollection.doc(idCluster).collection('gudang');
  //   return gudangCollection.where('jenis', isEqualTo: 'Elektrik').snapshots();
  // }

  // // menampilkan list perangkat komunikasi data
  // Stream<QuerySnapshot> listKd(String idCluster) {
  //   CollectionReference gudangCollection =
  //       clusterCollection.doc(idCluster).collection('gudang');
  //   return gudangCollection
  //       .where('jenis', isEqualTo: 'Komunikasi Data')
  //       .snapshots();
  // }

  // // menampilkan list sensor
  // Stream<QuerySnapshot> listSensor(String idCluster) {
  //   CollectionReference gudangCollection =
  //       clusterCollection.doc(idCluster).collection('gudang');
  //   return gudangCollection.where('jenis', isEqualTo: 'Sensor').snapshots();
  // }

  // // menampilkan list IT
  // Stream<QuerySnapshot> listIt(String idCluster) {
  //   CollectionReference gudangCollection =
  //       clusterCollection.doc(idCluster).collection('gudang');
  //   return gudangCollection.where('jenis', isEqualTo: 'IT').snapshots();
  // }

  // // menampilkan list Sipil
  // Stream<QuerySnapshot> listSipil(String idCluster) {
  //   CollectionReference gudangCollection =
  //       clusterCollection.doc(idCluster).collection('sipil');
  //   return gudangCollection.where('jenis', isEqualTo: 'Sipil').snapshots();
  // }

// ASET
  // menampilkan list aset mekanik
  Stream<QuerySnapshot> listMekanik(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('mekanik');
    return asetCollection.snapshots();
  }

  Future<void> addMekanik({
    String? id,
    String? spd11,
    String? spd12,
    String? spd13,
    String? spd14,
    String? spd15,
    String? lokasi,
    String? tglPasang,
    String? idPerangkat,
    String? idCluster,
    String? url1,
    String? url2,
    File? img1,
    File? img2,
  }) async {
    DocumentReference documentReferencer = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat);
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('mekanik/$time/1.png');
    final ref2 = FirebaseStorage.instance.ref('mekanik/$time/2.png');
    await ref.putFile(img1!);
    await ref2.putFile(img2!);
    url1 = await ref.getDownloadURL();
    url2 = await ref2.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'spd11': spd11,
      'spd12': spd12,
      'spd13': spd13,
      'spd14': spd14,
      'spd15': spd15,
      'lokasi': lokasi,
      'tglPasang': tglPasang,
      'img1': url1,
      'img2': url2,
    };

    await documentReferencer
        .collection('mekanik')
        .doc()
        .set(data)
        .whenComplete(() => print("Aset mekanik berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> listElektrik(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('elektrik');
    return asetCollection.snapshots();
  }

  Future<void> addElektrik({
    String? id,
    String? spd21,
    String? spd22,
    String? spd23,
    String? spd24,
    String? spd25,
    String? lokasi,
    String? tglPasang,
    String? idPerangkat,
    String? idCluster,
    String? url1,
    String? url2,
    File? img1,
    File? img2,
  }) async {
    DocumentReference documentReferencer = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat);
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('elektrik/$time/1.png');
    final ref2 = FirebaseStorage.instance.ref('elektrik/$time/2.png');
    await ref.putFile(img1!);
    await ref2.putFile(img2!);
    url1 = await ref.getDownloadURL();
    url2 = await ref2.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'spd21': spd21,
      'spd22': spd22,
      'spd23': spd23,
      'spd24': spd24,
      'spd25': spd25,
      'lokasi': lokasi,
      'tglPasang': tglPasang,
      'img1': url1,
      'img2': url2,
    };

    await documentReferencer
        .collection('elektrik')
        .doc()
        .set(data)
        .whenComplete(() => print("Aset elektrik berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> listKd(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('kd');
    return asetCollection.snapshots();
  }

  Future<void> addKd({
    String? id,
    String? spd31,
    String? spd32,
    String? spd33,
    String? spd34,
    String? spd35,
    String? lokasi,
    String? tglPasang,
    String? idPerangkat,
    String? idCluster,
    String? url1,
    String? url2,
    File? img1,
    File? img2,
  }) async {
    DocumentReference documentReferencer = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat);
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('kd/$time/1.png');
    final ref2 = FirebaseStorage.instance.ref('kd/$time/2.png');
    await ref.putFile(img1!);
    await ref2.putFile(img2!);
    url1 = await ref.getDownloadURL();
    url2 = await ref2.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'spd31': spd31,
      'spd32': spd32,
      'spd33': spd33,
      'spd34': spd34,
      'spd35': spd35,
      'lokasi': lokasi,
      'tglPasang': tglPasang,
      'img1': url1,
      'img2': url2,
    };

    await documentReferencer
        .collection('kd')
        .doc()
        .set(data)
        .whenComplete(() => print("Aset Komunikasi data berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> listSensor(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('sensor');
    return asetCollection.snapshots();
  }

  Future<void> addSensor({
    String? id,
    String? spd41,
    String? spd42,
    String? spd43,
    String? spd44,
    String? spd45,
    String? lokasi,
    String? tglPasang,
    String? idPerangkat,
    String? idCluster,
    String? url1,
    String? url2,
    File? img1,
    File? img2,
  }) async {
    DocumentReference documentReferencer = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat);
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('sensor/$time/1.png');
    final ref2 = FirebaseStorage.instance.ref('sensor/$time/2.png');
    await ref.putFile(img1!);
    await ref2.putFile(img2!);
    url1 = await ref.getDownloadURL();
    url2 = await ref2.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'spd41': spd41,
      'spd42': spd42,
      'spd43': spd43,
      'spd44': spd44,
      'spd45': spd45,
      'lokasi': lokasi,
      'tglPasang': tglPasang,
      'img1': url1,
      'img2': url2,
    };

    await documentReferencer
        .collection('sensor')
        .doc()
        .set(data)
        .whenComplete(() => print("Aset sensor berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> listIt(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('it');
    return asetCollection.snapshots();
  }

  Future<void> addIt({
    String? id,
    String? spd51,
    String? spd52,
    String? spd53,
    String? spd54,
    String? spd55,
    String? lokasi,
    String? tglPasang,
    String? idPerangkat,
    String? idCluster,
    String? url1,
    String? url2,
    File? img1,
    File? img2,
  }) async {
    DocumentReference documentReferencer = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat);
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('it/$time/1.png');
    final ref2 = FirebaseStorage.instance.ref('it/$time/2.png');
    await ref.putFile(img1!);
    await ref2.putFile(img2!);
    url1 = await ref.getDownloadURL();
    url2 = await ref2.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'spd51': spd51,
      'spd52': spd52,
      'spd53': spd53,
      'spd54': spd54,
      'spd55': spd55,
      'lokasi': lokasi,
      'tglPasang': tglPasang,
      'img1': url1,
      'img2': url2,
    };

    await documentReferencer
        .collection('it')
        .doc()
        .set(data)
        .whenComplete(() => print("Aset IT berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> listSipil(String idCluster, String idPerangkat) {
    CollectionReference asetCollection = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat)
        .collection('sipil');
    return asetCollection.snapshots();
  }

  Future<void> addSipil({
    String? id,
    String? spd61,
    String? spd62,
    String? spd63,
    String? spd64,
    String? spd65,
    String? lokasi,
    String? tglPasang,
    String? idPerangkat,
    String? idCluster,
    String? url1,
    String? url2,
    File? img1,
    File? img2,
  }) async {
    DocumentReference documentReferencer = clusterCollection
        .doc(idCluster)
        .collection('perangkat')
        .doc(idPerangkat);
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('sipil/$time/1.png');
    final ref2 = FirebaseStorage.instance.ref('sipil/$time/2.png');
    await ref.putFile(img1!);
    await ref2.putFile(img2!);
    url1 = await ref.getDownloadURL();
    url2 = await ref2.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'spd61': spd61,
      'spd62': spd62,
      'spd63': spd63,
      'spd64': spd64,
      'spd65': spd65,
      'lokasi': lokasi,
      'tglPasang': tglPasang,
      'img1': url1,
      'img2': url2,
    };

    await documentReferencer
        .collection('sipil')
        .doc()
        .set(data)
        .whenComplete(() => print("Aset sipil berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  // menampilkan list aset menunggu
  Stream<QuerySnapshot> listAsetMenunggu() {
    return asetCollection
        .where('statusKonfirmasi', isEqualTo: 'Menunggu')
        .snapshots();
  }

  // menampilkan list aset diterima
  Stream<QuerySnapshot> listAsetDiterima() {
    return asetCollection
        .where('statusKonfirmasi', isEqualTo: 'Diterima')
        .snapshots();
  }

  // menampilkan list aset ditolak
  Stream<QuerySnapshot> listAsetDitolak() {
    return asetCollection
        .where('statusKonfirmasi', isEqualTo: 'Ditolak')
        .snapshots();
  }

  // konfirmasi aset
  Future<void> konfirmasiAset({
    String? asetId,
    String? statusKonfirmasi,
  }) async {
    DocumentReference docReferencer = asetCollection.doc(asetId);
    Map<String, dynamic> data = <String, dynamic>{
      "statusKonfirmasi": statusKonfirmasi,
    };
    await docReferencer
        .update(data)
        .whenComplete(() => print("Konfirmasi berhasil"))
        .catchError((e) => print(e));
  }

// // PENGECEKAN
  // menampilkan list pengecekan
  Stream<QuerySnapshot> listPengecekan() {
    return pengecekanCollection.snapshots();
  }

//   // konfirmasi pengecekan
//   Future<void> konfirmasiPengecekan({
//     String? asetId,
//     String? konfirmasiPengecekan,
//   }) async {
//     DocumentReference docReferencer = clusterCollection.doc(asetId);
//     Map<String, dynamic> data = <String, dynamic>{
//       "konfirmasiPengecekan": konfirmasiPengecekan,
//     };
//     await docReferencer
//         .update(data)
//         .whenComplete(() => print("Konfirmasi berhasil"))
//         .catchError((e) => print(e));
//   }

// PERBAIKAN
  // menampilkan list perbaikan
  Stream<QuerySnapshot> listPerbaikan() {
    return perbaikanCollection.snapshots();
  }
//   // konfirmasi pengecekan
//   Future<void> konfirmasiPengecekan({
//     String? asetId,
//     String? konfirmasiPengecekan,
//   }) async {
//     DocumentReference docReferencer = clusterCollection.doc(asetId);
//     Map<String, dynamic> data = <String, dynamic>{
//       "konfirmasiPengecekan": konfirmasiPengecekan,
//     };
//     await docReferencer
//         .update(data)
//         .whenComplete(() => print("Konfirmasi berhasil"))
//         .catchError((e) => print(e));
//   }

// PERAWATAN
  // menampilkan list perawatan
  Stream<QuerySnapshot> listPerawatan() {
    return perawatanCollection.snapshots();
  }
//   // konfirmasi pengecekan
//   Future<void> konfirmasiPengecekan({
//     String? asetId,
//     String? konfirmasiPengecekan,
//   }) async {
//     DocumentReference docReferencer = clusterCollection.doc(asetId);
//     Map<String, dynamic> data = <String, dynamic>{
//       "konfirmasiPengecekan": konfirmasiPengecekan,
//     };
//     await docReferencer
//         .update(data)
//         .whenComplete(() => print("Konfirmasi berhasil"))
//         .catchError((e) => print(e));
//   }

}
