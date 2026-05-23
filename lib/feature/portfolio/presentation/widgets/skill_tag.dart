import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SkillTag extends StatelessWidget {
  const SkillTag(this.label, {super.key, this.small = false});

  final String label;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.tagBg : AppColors.lightTagBg;
    final fg = isDark ? AppColors.tagText : AppColors.lightTagText;
    final borderColor = isDark
        ? AppColors.accentDark.withValues(alpha: 0.2)
        : AppColors.accent.withValues(alpha: 0.25);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 12,
        vertical: small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: fg,
              fontSize: small ? 11 : 12,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}
