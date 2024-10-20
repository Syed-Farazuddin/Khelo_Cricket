import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khelo_cricket/core/toaster/toaster.dart';
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
  int loopCount = 0;
  late List<bool> check = List.filled(50, false);
  List<int> order = List.filled(50, 0);
  @override
  void dispose() {
    numbers.dispose();
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
          Center(
            child: CustomInputField(
              controller: numbers,
            ),
          ),
          Column(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: order.length,
                itemBuilder: (item, index) {
                  if (order[index] == 0) return const SizedBox.shrink();
                  return ListTile(
                    title: Text(
                      "Player ${index + 1} --- > ${order[index]}",
                      style: GoogleFonts.golosText(
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
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
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  void returnAPlayer() {
    int currNum = 0;
    if (numbers.text == "") {
      Toaster.onError(message: "Enter Total players");
      return;
    }
    debugPrint("The loop count is $loopCount");
    int totalPlayers = int.parse(numbers.text);
    if (loopCount >= totalPlayers) {
      debugPrint("All players are assigned");
      Toaster.onError(message: "All players are assigned");
      debugPrint(order.toString());
      return;
    }
    bool getPlayerNum = true;
    while (getPlayerNum) {
      currNum = Random().nextInt(totalPlayers) + 1;
      if (check[currNum] != true) {
        getPlayerNum = false;
        check[currNum] = true;
        order[loopCount] = currNum;
      }
    }
    setState(() {
      loopCount = loopCount + 1;
      currNumber = currNum;
    });
  }
}
