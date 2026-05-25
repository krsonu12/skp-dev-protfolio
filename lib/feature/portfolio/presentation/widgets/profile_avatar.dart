import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

/// Circular profile photo with an accent-coloured ring.
/// Uses [RepaintBoundary] so it never triggers parent repaints.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.radius = 36});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final borderWidth = radius * 0.06;
    final accentColor =
        context.isDark ? AppColors.accentDark : AppColors.accent;

    return RepaintBoundary(
      child: Container(
        width: radius * 2 + borderWidth * 2,
        height: radius * 2 + borderWidth * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: accentColor, width: borderWidth),
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: context.surfaceElevatedColor,
          backgroundImage: const AssetImage(AppConstants.profileImage),
        ),
      ),
    );
  }
}
