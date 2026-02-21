import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_and_wash/core/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.fromSeed(seedColor: AppColors.seedColor);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.dmSans(
          color: AppColors.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.secText,
        ),

        bodySmall: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      
    );
  }
}
