import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../../../../core/theme/theme_notifier.dart';
import 'hover_region.dart';
import 'profile_avatar.dart';

class PortfolioNavBar extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isNarrow = MediaQuery.of(context).size.width < 700;
    final isDark = context.isDark;
    final accentColor = context.accentColor;
    final bgColor = isDark
        ? AppColors.background.withValues(alpha: 0.95)
        : AppColors.lightBackground.withValues(alpha: 0.97);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: context.borderColor)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          const ProfileAvatar(
            radius: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HoverRegion(
                builder: (context, ref, hovered) => GestureDetector(
                  onTap: () => onTap(-1),
                  child: Text(
                    'Sonu Kumar Paswan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: hovered
                              ? accentColor.withValues(alpha: 0.7)
                              : accentColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                  ),
                ),
              ),
              Text(
                'Senior Flutter Developer',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: context.tagTextColor,
                      letterSpacing: 0.3,
                    ),
              )
            ],
          ),

          const Spacer(),

          // Nav links (wide only)
          if (!isNarrow)
            Row(
              children: _items.map((item) {
                final isActive = activeIndex == item.$2;
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: HoverRegion(
                    builder: (context, ref, hovered) => GestureDetector(
                      onTap: () => onTap(item.$2),
                      child: Text(
                        item.$1,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: isActive || hovered
                                  ? accentColor
                                  : context.secondaryText,
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

          // Theme toggle
          const SizedBox(width: 24),
          const _ThemeToggle(),
        ],
      ),
    );
  }
}

// ── Theme toggle — hover via HoverRegion, zero setState ──────────────────────

class _ThemeToggle extends ConsumerWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final accent = context.accentColor;

    return HoverRegion(
      builder: (context, ref, hovered) {
        return GestureDetector(
          onTap: () => ref.read(themeNotifierProvider.notifier).toggle(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  hovered ? context.surfaceElevatedColor : Colors.transparent,
              border: Border.all(
                color: hovered ? accent : context.borderColor,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  RotationTransition(turns: anim, child: child),
              child: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                key: ValueKey(isDark),
                size: 16,
                color: hovered ? accent : context.secondaryText,
              ),
            ),
          ),
        );
      },
    );
  }
}
