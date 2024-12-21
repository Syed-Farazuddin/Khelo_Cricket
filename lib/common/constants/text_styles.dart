import 'package:crick_hub/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static TextStyle mediumText = GoogleFonts.golosText(
    fontSize: 14,
    color: AppColors.subTitles,
    fontWeight: FontWeight.w600,
  );
  static TextStyle large = GoogleFonts.golosText(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle largeText = GoogleFonts.golosText(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading = GoogleFonts.golosText(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle small = GoogleFonts.golosText(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
