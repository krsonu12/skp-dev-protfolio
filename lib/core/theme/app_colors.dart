import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Dark palette ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF111111);
  static const Color surfaceElevated = Color(0xFF1A1A1A);
  static const Color border = Color(0xFF2A2A2A);
  static const Color borderLight = Color(0xFF333333);

  static const Color textPrimary = Color(0xFFF0F0F0);
  static const Color textSecondary = Color(0xFF888888);
  static const Color textMuted = Color(0xFF555555);

  // ── Light palette ─────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8F8F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF0F0EC);
  static const Color lightBorder = Color(0xFFDDDDD8);
  static const Color lightBorderLight = Color(0xFFE8E8E4);

  static const Color lightTextPrimary = Color(0xFF0A0A0A);
  static const Color lightTextSecondary = Color(0xFF555550);
  static const Color lightTextMuted = Color(0xFFAAAAAA);

  // ── Accent — shared across both modes ─────────────────────────────────────
  static const Color accent =
      Color(0xFF00A86B); // slightly deeper for light readability
  static const Color accentDark = Color(0xFF00E5A0); // brighter for dark mode
  static const Color accentDim = Color(0xFF00B87A);
  static const Color accentGlow = Color(0x2000E5A0);

  // ── Tag / chip ─────────────────────────────────────────────────────────────
  static const Color tagBg = Color(0xFF1E2A24);
  static const Color tagText = Color(0xFF00E5A0);
  static const Color lightTagBg = Color(0xFFE6F5EF);
  static const Color lightTagText = Color(0xFF00875A);

  // ── Section divider ────────────────────────────────────────────────────────
  static const Color divider = Color(0xFF1E1E1E);
  static const Color lightDivider = Color(0xFFE4E4E0);
}
