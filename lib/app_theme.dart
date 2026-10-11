
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFFF5EEE2);
  static const Color primary = Color(0xFF0B4F36);
  static const Color primaryLight = Color(0xFFD8E4D6);
  static const Color card = Color(0xFFFFFBF1);
  static const Color border = Color(0xFFCCD6C2);
  static const Color textDark = Color(0xFF1F2421);
  static const Color textGrey = Color(0xFF6B6F68);
  static const Color textMuted = Color(0xFF8E9189);
  static const Color amber = Color(0xFFD9963A);
  static const Color beigeTile = Color(0xFFEBE2D3);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.background,
      ),
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: GoogleFonts.inter().fontFamily,
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
    );
  }
}
