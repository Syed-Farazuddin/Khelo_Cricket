import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    this.showIcon = false,
  });
  final Function() onTap;
  final String title;
  final IconData? icon;
  final bool? showIcon;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.golosText(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showIcon == true)
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        icon,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
