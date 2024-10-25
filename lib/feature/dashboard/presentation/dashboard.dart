import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khelo_cricket/feature/flpCoin/presentation/pages/flip_coin.dart';
import 'package:khelo_cricket/feature/numberPlayer/presentation/pages/number_player.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currpage = 0;
  List<Widget> pages = const [
    TossACoin(),
    GetYourNumber(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Khelo Cricket",
          style: GoogleFonts.golosText(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        // backgroundColor: Colors.amber[950],
        child: ListView(
          padding: EdgeInsets.zero, // Removes default padding
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                  // color: Colors.black,
                  ),
              child: Text(
                'Khelo Cricket',
                style: GoogleFonts.golosText(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle navigation or actions here
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle navigation or actions here
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contact'),
              onTap: () {
                // Handle navigation or actions here
              },
            ),
          ],
        ),
      ),
      body: pages[_currpage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currpage,
        selectedItemColor: Colors.blue, // Color for selected icon
        unselectedItemColor: Colors.grey[850], // Color for unselected icon
        selectedFontSize: 16, // Size of selected icon text
        unselectedFontSize: 12, // Size of unselected icon text
        onTap: (value) {
          setState(() {
            _currpage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/assets/svgs/coinSvg.svg",
              height: 30,
              width: 30,
            ),
            label: "Toss",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/assets/svgs/numbers.svg",
              width: 30,
              height: 30,
            ),
            label: "Get your Number",
          ),
        ],
      ),
    );
  }
}
