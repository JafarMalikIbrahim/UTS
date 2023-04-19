import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/home/home_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItem(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    // return Container(
    //   color: Color.fromARGB(225, 0, 74, 173),
    //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    //   child: Column(
    //     children: [
    //       CircleAvatar(
    //         radius: 45,
    //         backgroundImage: AssetImage('img/polinema.png'),
    //       )
    //     ],
    //   ),
    // );
    return UserAccountsDrawerHeader(
      accountName: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Admin"),
        ],
      ),
      accountEmail: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("admin@gmail.com"),
        ],
      ),
      currentAccountPicture: const Image(
        image: AssetImage('img/polinema.png'),
        alignment: Alignment.center,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(225, 0, 74, 173),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Users'),
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     // builder: (context) => LaporanScreen(),
            //   ),
            // );
          },
        ),
        const Divider(
          color: Color.fromARGB(225, 0, 74, 173),
          thickness: 2,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {},
        ),
      ],
    );
  }
}
