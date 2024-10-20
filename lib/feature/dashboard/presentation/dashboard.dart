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
      body: pages[_currpage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currpage,
        selectedItemColor: Colors.blue, // Color for selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icon
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
