import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  final int activeIndex;
  final void Function(int) onTap;

  static const _items = [
    ('ABOUT', 0),
    ('EXPERIENCE', 1),
    ('PROJECTS', 2),
    ('SKILLS', 3),
    ('CONTACT', 4),
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      color: AppColors.background.withValues(alpha: 0.95),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          // Logo / name
          GestureDetector(
            onTap: () => onTap(-1),
            child: Text(
              'SKP',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
            ),
          ),
          const Spacer(),
          if (!isNarrow)
            Row(
              children: _items.map((item) {
                final isActive = activeIndex == item.$2;
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: GestureDetector(
                    onTap: () => onTap(item.$2),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        item.$1,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: isActive
                                  ? AppColors.accent
                                  : AppColors.textSecondary,
                              letterSpacing: 1.5,
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w400,
                            ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
