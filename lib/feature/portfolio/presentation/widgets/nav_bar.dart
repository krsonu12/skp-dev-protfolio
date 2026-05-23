import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_notifier.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Adaptive nav bar colors
    final bgColor = isDark
        ? AppColors.background.withValues(alpha: 0.95)
        : AppColors.lightBackground.withValues(alpha: 0.97);
    final accentColor = isDark ? AppColors.accentDark : AppColors.accent;
    final textColor =
        isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.border : AppColors.lightBorder;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(color: borderColor),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () => onTap(-1),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                'SKP',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
              ),
            ),
          ),

          const Spacer(),

          // Nav links (wide only)
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
                              color: isActive ? accentColor : textColor,
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
          _ThemeToggle(isDark: isDark),
        ],
      ),
    );
  }
}

class _ThemeToggle extends ConsumerStatefulWidget {
  const _ThemeToggle({required this.isDark});
  final bool isDark;

  @override
  ConsumerState<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends ConsumerState<_ThemeToggle> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final accentColor = isDark ? AppColors.accentDark : AppColors.accent;
    final borderColor = isDark ? AppColors.border : AppColors.lightBorder;
    final iconColor = _hovered
        ? accentColor
        : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => ref.read(themeNotifierProvider.notifier).toggle(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovered
                ? (isDark
                    ? AppColors.surfaceElevated
                    : AppColors.lightSurfaceElevated)
                : Colors.transparent,
            border: Border.all(
              color: _hovered ? accentColor : borderColor,
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
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
