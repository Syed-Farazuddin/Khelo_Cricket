import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartMatch extends StatefulWidget {
  const StartMatch({super.key});

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Teams",
            style: GoogleFonts.golosText(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              teamDisplay(label: "Team A"),
              teamDisplay(label: "Team B"),
            ],
          ),
        ],
      ),
    );
  }

  Widget teamDisplay({required String label}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Text(
        label,
        style: GoogleFonts.golosText(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}