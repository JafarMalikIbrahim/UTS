// import 'package:flutter/material.dart';
// import 'package:manajemen_aset/pages/asset/asset_list_page.dart';
// import 'package:manajemen_aset/pages/home/home_screen.dart';
// import 'package:manajemen_aset/pages/laporan/laporan_screen.dart';
// import 'package:manajemen_aset/pages/location/location_screen.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   List pages = [
//     HomeScreen(),
//     AssetScreen(),
//     LocationScreen(),
//     LaporanScreen(),
//   ];

//   int currentIndex = 0;
//   void onTap(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = HomeScreen();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(bucket: bucket, child: currentScreen),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.qr_code_scanner),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // bottomNavigationBar: BottomNavigationBar(
//       //   onTap: onTap,
//       //   currentIndex: currentIndex,
//       //   selectedFontSize: 12,
//       //   unselectedItemColor: Colors.grey.withOpacity(0.5),
//       //   items: const [
//       //     BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
//       //     BottomNavigationBarItem(label: 'Asset', icon: Icon(Icons.inventory)),
//       //     BottomNavigationBarItem(
//       //         label: 'Laporan', icon: Icon(Icons.description)),
//       //     BottomNavigationBarItem(
//       //         label: 'Statistic', icon: Icon(Icons.qr_code_scanner)),
//       //     // BottomNavigationBarItem(
//       //     //     label: 'Profile', icon: Icon(Icons.person_pin))
//       //   ],
//       // ),
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 8,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               MaterialButton(
//                 minWidth: 40,
//                 onPressed: () {
//                   setState(() {
//                     currentIndex = 0;
//                     currentScreen = HomeScreen();
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.home_filled,
//                       color: currentIndex == 0 ? Colors.blue : Colors.grey,
//                     ),
//                     // Text(
//                     //   'Home',
//                     //   style: TextStyle(
//                     //     color: currentIndex == 0 ? Colors.blue : Colors.grey,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               MaterialButton(
//                 minWidth: 40,
//                 onPressed: () {
//                   setState(() {
//                     currentIndex = 1;
//                     currentScreen = AssetScreen();
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.inventory,
//                       color: currentIndex == 1 ? Colors.blue : Colors.grey,
//                     ),
//                     // Text(
//                     //   'Asset',
//                     //   style: TextStyle(
//                     //     color: currentIndex == 1 ? Colors.blue : Colors.grey,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               MaterialButton(
//                 minWidth: 40,
//                 onPressed: () {
//                   setState(() {
//                     currentIndex = 2;
//                     currentScreen = LocationScreen();
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.map,
//                       color: currentIndex == 2 ? Colors.blue : Colors.grey,
//                     ),
//                     // Text(
//                     //   'Location',
//                     //   style: TextStyle(
//                     //     color: currentIndex == 2 ? Colors.blue : Colors.grey,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               MaterialButton(
//                 minWidth: 40,
//                 onPressed: () {
//                   setState(() {
//                     currentIndex = 3;
//                     currentScreen = LaporanScreen();
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.description,
//                       color: currentIndex == 3 ? Colors.blue : Colors.grey,
//                     ),
//                     // Text(
//                     //   'Laporan',
//                     //   style: TextStyle(
//                     //     color: currentIndex == 3 ? Colors.blue : Colors.grey,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
