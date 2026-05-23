import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SkillTag extends StatelessWidget {
  const SkillTag(this.label, {super.key, this.small = false});

  final String label;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 12,
        vertical: small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.tagBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.tagText,
              fontSize: small ? 11 : 12,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}
