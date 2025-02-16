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
    return SizedBox(
      height: 50,
      child: Container(
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
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showIcon == true)
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 4,
                      )
                    ],
                  ),
                Text(
                  title,
                  style: GoogleFonts.golosText(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
