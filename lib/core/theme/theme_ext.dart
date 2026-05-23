import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Convenience extension on [BuildContext] to resolve adaptive colors
/// without repeating `Theme.of(context).brightness == Brightness.dark` everywhere.
extension ThemeExt on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get bgColor =>
      isDark ? AppColors.background : AppColors.lightBackground;
  Color get surfaceColor => isDark ? AppColors.surface : AppColors.lightSurface;
  Color get surfaceElevatedColor =>
      isDark ? AppColors.surfaceElevated : AppColors.lightSurfaceElevated;
  Color get borderColor => isDark ? AppColors.border : AppColors.lightBorder;
  Color get dividerColor => isDark ? AppColors.divider : AppColors.lightDivider;

  Color get primaryText =>
      isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
  Color get secondaryText =>
      isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
  Color get mutedText =>
      isDark ? AppColors.textMuted : AppColors.lightTextMuted;

  Color get accentColor => isDark ? AppColors.accentDark : AppColors.accent;
  Color get tagBgColor => isDark ? AppColors.tagBg : AppColors.lightTagBg;
  Color get tagTextColor => isDark ? AppColors.tagText : AppColors.lightTagText;
}
