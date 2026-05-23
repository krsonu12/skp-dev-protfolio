import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../widgets/skill_tag.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onCtaTap});

  final VoidCallback onCtaTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 700;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 24 : 80,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'FLUTTER DEVELOPER · ${AppConstants.location.toUpperCase()}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.accentColor,
                  letterSpacing: 2.5,
                ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isNarrow ? 42 : 72,
                  ),
              children: [
                const TextSpan(text: 'Building apps\nthat '),
                TextSpan(
                  text: 'actually',
                  style: TextStyle(
                    color: context.accentColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(text: '\nwork.'),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 400.ms)
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "I'm ${AppConstants.name} — a Senior Flutter Developer with "
              '${AppConstants.yearsExperience} years shipping production mobile applications. '
              'I specialise in clean architecture, reactive state management, and building '
              'scalable multi-module systems from greenfield to store release.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
          const SizedBox(height: 48),
          Wrap(
            spacing: 40,
            runSpacing: 16,
            children: const [
              _StatItem(value: '5+', label: 'YEARS EXPERIENCE'),
              _StatItem(value: '10+', label: 'PROJECTS DELIVERED'),
              _StatItem(value: '<0.1%', label: 'CRASH-FREE RATE'),
              _StatItem(value: '3', label: 'DEVS MENTORED'),
            ],
          ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
          const SizedBox(height: 56),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _CtaButton(label: 'View Work', onTap: onCtaTap, filled: true),
              _CtaButton(
                  label: 'Get in touch →', onTap: onCtaTap, filled: false),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
          const SizedBox(height: 64),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              SkillTag('Flutter'),
              SkillTag('Clean Architecture'),
              SkillTag('BLoC · Riverpod'),
              SkillTag('Firebase'),
              SkillTag('AWS'),
              SkillTag('CI/CD'),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 1200.ms),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: context.accentColor,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.mutedText,
                letterSpacing: 1.5,
              ),
        ),
      ],
    );
  }
}

class _CtaButton extends StatefulWidget {
  const _CtaButton({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = context.accentColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: widget.filled
                ? (_hovered ? AppColors.accentDim : accent)
                : Colors.transparent,
            border: Border.all(
              color: widget.filled
                  ? Colors.transparent
                  : (_hovered ? accent : context.borderColor),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: widget.filled
                      ? context.bgColor
                      : (_hovered ? accent : context.secondaryText),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
