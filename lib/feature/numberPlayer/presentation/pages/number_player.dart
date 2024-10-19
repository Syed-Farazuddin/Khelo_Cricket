import 'package:flutter/material.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Custombutton(
                  onTap: returnAPlayer,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  int returnAPlayer() {
    int currNum = 0;
    int totalPlayers = int.parse(numbers.text);
    List<bool> check = List.filled(totalPlayers, false);
    setState(() {
      currNumber = currNum;
    });
    return currNum;
  }
}
