import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      '— $label',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.accent,
            letterSpacing: 2,
          ),
    );
  }
}
