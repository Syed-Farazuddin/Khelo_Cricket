import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khelo_cricket/feature/numberPlayer/presentation/widget/custom_button.dart';
import 'package:khelo_cricket/feature/numberPlayer/presentation/widget/custom_input.dart';

class GetYourNumber extends StatefulWidget {
  const GetYourNumber({super.key});

  @override
  State<GetYourNumber> createState() => _GetYourNumberState();
}

class _GetYourNumberState extends State<GetYourNumber> {
  TextEditingController numbers = TextEditingController();
  int currNumber = 0;
  late List<bool> check = List.filled(50, growable: true, false);
  @override
  void dispose() {
    numbers.dispose();
    check.length = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Expanded(child: SizedBox()),
          Center(
            child: CustomInputField(
              controller: numbers,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your New Player Number is $currNumber",
                  style: GoogleFonts.golosText(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Custombutton(
                onTap: returnAPlayer,
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  void returnAPlayer() {
    int currNum = 0;
    int totalPlayers = int.parse(numbers.text);
    // check = List.filled(totalPlayers + 1, false);
    bool getPlayerNum = true;
    while (getPlayerNum) {
      currNum = Random().nextInt(totalPlayers) + 1;
      debugPrint(currNum.toString());
      debugPrint(check.toString());
      if (check[currNum] != true) {
        getPlayerNum = false;
        check[currNum] = true;
      }
    }
    setState(() {
      currNumber = currNum;
    });
  }
}
