// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// final FirebaseAuth auth = FirebaseAuth.instance;
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

// class UserController {
//   // TextEditingController emailC = TextEditingController();
//   // TextEditingController namaC = TextEditingController();
//   static Future<void> createUser({
//     String? email,
//     String? nama,
//     String? role,
//   }) async {
//     if (email!.isNotEmpty && nama!.isNotEmpty) {
//       try {
//         UserCredential userCredential = await auth
//             .createUserWithEmailAndPassword(email: email, password: "12345678");
//         if (userCredential.user != null) {
//           String uid = userCredential.user!.uid;
//           await firestore.collection("user").doc(uid).set({
//             "nama": nama,
//             "email": email,
//             "uid": uid,
//             "role": role,
//             "createdAt": DateTime.now().toIso8601String()
//           });
//         }
//         print(userCredential);
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           const SnackBar(
//               content: Text("Password yang digunakan terlalu singkat"));
//         } else if (e.code == 'email-already-in-use') {
//           const SnackBar(content: Text("User telah terdaftar"));
//         }
//       } catch (e) {
//         const SnackBar(content: Text("Tidak dapat menambahkan user"));
//       }
//     } else {
//       const SnackBar(content: Text("Email dan nama harus terisi"));
//     }
//   }

//   static Stream<QuerySnapshot> listUser() {
//     CollectionReference userCollection = firestore.collection('user');

//     return userCollection.orderBy('nama').snapshots();
//   }

//   static Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
//     String? uid = auth.currentUser?.uid;
//     yield* firestore.collection("user").doc(uid).snapshots();
//   }
// }
