import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    required this.width,
    this.isCircle = false,
    this.showIcon = false,
    this.radius,
    this.color = Colors.white,
    this.textColor = Colors.black,
  });
  final double width;
  final Color color;
  final Color textColor;
  final Function() onTap;
  final String title;
  final IconData? icon;
  final bool showIcon;
  final double? radius;
  final bool isCircle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        color: color,
        border: Border.all(
          color: color,
          width: 1,
        ),
        borderRadius: isCircle == false
            ? BorderRadius.circular(
                radius ?? 12,
              )
            : BorderRadius.zero,
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
                  color: textColor,
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
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
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
