import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TossACoin extends StatefulWidget {
  const TossACoin({super.key});

  @override
  State<TossACoin> createState() => _TossACoinState();
}

class _TossACoinState extends State<TossACoin> {
  int _currTossValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_currTossValue == 0)
                  const Center(
                    child: Image(
                      image: AssetImage(
                        "lib/assets/customHead.png",
                      ),
                      height: 300,
                      width: 300,
                      colorBlendMode: BlendMode.lighten,
                      // opacity: ,
                    ),
                  ),
                if (_currTossValue == 1)
                  const Center(
                    child: Image(
                      image: AssetImage(
                        "lib/assets/customTail.png",
                      ),
                      height: 300,
                      width: 300,
                      colorBlendMode: BlendMode.lighten,
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: tossACoin,
            child: Text(
              "Let's start",
              style: GoogleFonts.golosText(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  void tossACoin() {
    dynamic toss = Random().nextInt(2);
    setState(() {
      _currTossValue = toss;
    });
    debugPrint("The value of toss is $toss");
  }
}
