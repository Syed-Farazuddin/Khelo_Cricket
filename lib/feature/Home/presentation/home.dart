import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khelo_cricket/common/widgets/custom_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Custombutton(
                  onTap: () {},
                  title: "Start Match",
                  icon: (Icons.add),
                  showIcon: true,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Custombutton(
                  onTap: () {},
                  title: "Start  tournament",
                  icon: (Icons.add),
                  showIcon: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Your Previous Matches",
            style: GoogleFonts.golosText(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
