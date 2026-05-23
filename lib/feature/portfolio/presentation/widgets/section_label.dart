import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      '— $label',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isDark ? AppColors.accentDark : AppColors.accent,
            letterSpacing: 2,
          ),
    );
  }
}
