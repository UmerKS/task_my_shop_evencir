// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_my_shop_evencir/helper/app_colors.dart';

class AppTextStyle {
  static TextStyle style1 = GoogleFonts.playfairDisplay(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
  );
  static TextStyle style2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
  );
  static TextStyle style3 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
  );
}
