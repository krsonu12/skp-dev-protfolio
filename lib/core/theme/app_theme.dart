import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ── Dark ──────────────────────────────────────────────────────────────────
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.accentDark,
        onPrimary: AppColors.background,
        secondary: AppColors.accentDim,
        onSecondary: AppColors.background,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      textTheme: _buildTextTheme(
        base: ThemeData.dark().textTheme,
        primary: AppColors.textPrimary,
        secondary: AppColors.textSecondary,
        accent: AppColors.accentDark,
        muted: AppColors.textMuted,
      ),
      dividerColor: AppColors.divider,
      cardColor: AppColors.surfaceElevated,
    );
  }

  // ── Light ─────────────────────────────────────────────────────────────────
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        surface: AppColors.lightSurface,
        primary: AppColors.accent,
        onPrimary: AppColors.lightBackground,
        secondary: AppColors.accentDim,
        onSecondary: AppColors.lightBackground,
        onSurface: AppColors.lightTextPrimary,
        outline: AppColors.lightBorder,
      ),
      textTheme: _buildTextTheme(
        base: ThemeData.light().textTheme,
        primary: AppColors.lightTextPrimary,
        secondary: AppColors.lightTextSecondary,
        accent: AppColors.accent,
        muted: AppColors.lightTextMuted,
      ),
      dividerColor: AppColors.lightDivider,
      cardColor: AppColors.lightSurfaceElevated,
    );
  }

  // ── Shared text theme builder ─────────────────────────────────────────────
  static TextTheme _buildTextTheme({
    required TextTheme base,
    required Color primary,
    required Color secondary,
    required Color accent,
    required Color muted,
  }) {
    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        color: primary,
        letterSpacing: -2,
        height: 1.0,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: primary,
        letterSpacing: -1.5,
        height: 1.05,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: primary,
        letterSpacing: -1,
        height: 1.1,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: accent,
        letterSpacing: 1.5,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: muted,
        letterSpacing: 1.2,
      ),
    );
  }
}
