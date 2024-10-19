import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, required this.onTap});
  final int Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            "Get Your Number",
            style: GoogleFonts.golosText(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
