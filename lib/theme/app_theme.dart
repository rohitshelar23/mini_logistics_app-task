import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickMoveColors {
  // Brand Palette
  static const Color primaryNavy = Color(0xFF0F172A);
  static const Color accentOrange = Color(0xFFEA580C);
  static const Color accentOrangeLight = Color(0xFFFFF7ED);
  static const Color accentOrangeDark = Color(0xFFC2410C);

  static const Color emeraldGreen = Color(0xFF10B981);
  static const Color emeraldGreenLight = Color(0xFFECFDF5);

  static const Color amberWarning = Color(0xFFF59E0B);
  static const Color amberWarningLight = Color(0xFFFEF3C7);

  static const Color redDanger = Color(0xFFEF4444);
  static const Color redDangerLight = Color(0xFFFEE2E2);

  // Surface & Neutral Tokens
  static const Color background = Color(0xFFF8FAFC);
  static const Color surfaceWhite = Colors.white;
  static const Color surfaceSubtle = Color(0xFFF1F5F9);
  static const Color surfaceContainer = Color(0xFFEFF4FF);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Typography
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
}

class QuickMoveTheme {
  static ThemeData get lightTheme {
    final baseFont = GoogleFonts.plusJakartaSansTextTheme();

    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: QuickMoveColors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: QuickMoveColors.accentOrange,
        primary: QuickMoveColors.accentOrange,
        secondary: QuickMoveColors.primaryNavy,
        surface: QuickMoveColors.surfaceWhite,
      ),

      textTheme: baseFont.copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: QuickMoveColors.textPrimary,
          letterSpacing: -0.5,
        ),

        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: QuickMoveColors.textPrimary,
        ),

        titleMedium: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: QuickMoveColors.textPrimary,
        ),

        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: QuickMoveColors.textPrimary,
        ),

        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: QuickMoveColors.textSecondary,
        ),

        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: QuickMoveColors.primaryNavy,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: QuickMoveColors.accentOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Updated for newer Flutter versions.
      cardTheme: CardThemeData(
        color: QuickMoveColors.surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: QuickMoveColors.borderLight,
            width: 1,
          ),
        ),
      ),
    );
  }
}