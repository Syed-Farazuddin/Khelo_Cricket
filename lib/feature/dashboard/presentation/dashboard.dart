import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khelo_cricket/feature/flpCoin/presentation/pages/FlipCoin.dart';
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
        onTap: (value) {
          setState(() {
            _currpage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                "lib/assets/flipCoin.jpg",
              ),
              width: 30,
              height: 30,
            ),
            label: "toss a Coin",
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                "lib/assets/selectNum.jpg",
              ),
              width: 30,
              height: 30,
            ),
            label: "Get your Number",
          )
        ],
      ),
    );
  }
}
