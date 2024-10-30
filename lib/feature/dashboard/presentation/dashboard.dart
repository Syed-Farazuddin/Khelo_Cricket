import 'package:crick_hub/core/colors/colors.dart';
import 'package:crick_hub/feature/Home/presentation/home.dart';
import 'package:crick_hub/feature/flpCoin/presentation/pages/flip_coin.dart';
import 'package:crick_hub/feature/numberPlayer/presentation/pages/number_player.dart';
import 'package:crick_hub/feature/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currpage = 1;
  List<Widget> pages = [
    const TossMyCoin(),
    const Home(),
    const ProfilePage(),
    const GetYourNumber(),
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
          "CrickHub",
          style: GoogleFonts.golosText(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.dark,
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
        selectedItemColor:
            Colors.grey.withOpacity(0.9), // Color for selected icon
        unselectedItemColor:
            Colors.grey.withOpacity(0.4), // Color for unselected icon
        selectedFontSize: 16, // Size of selected icon text
        unselectedFontSize: 12, // Size of unselected icon text
        onTap: (value) {
          setState(
            () {
              _currpage = value;
            },
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                _currpage == 0
                    ? Colors.grey.withOpacity(0.9)
                    : Colors.grey.withOpacity(0.4),
                BlendMode.srcIn,
              ),
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
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              // color: AppColors.white,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                _currpage == 3
                    ? Colors.grey.withOpacity(0.9)
                    : Colors.grey.withOpacity(0.4),
                BlendMode.srcIn,
              ),
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
