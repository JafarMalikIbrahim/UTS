import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            const ColorScheme.light(primary: Color.fromARGB(225, 18, 149, 117)),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        primaryColor: const Color.fromARGB(225, 18, 149, 117),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(225, 12, 144, 125),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(225, 18, 149, 117), elevation: 0),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
