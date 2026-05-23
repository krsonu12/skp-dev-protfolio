import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../widgets/hover_region.dart';
import '../../widgets/lottie_widget.dart';
import '../../widgets/skill_tag.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onCtaTap});

  final VoidCallback onCtaTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 900;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 24 : 80,
        vertical: isNarrow ? 80 : 120,
      ),
      child: isNarrow ? _buildNarrow(context) : _buildWide(context),
    );
  }

  // ── Wide layout: text left, Lottie right ──────────────────────────────────
  Widget _buildWide(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 55, child: _buildTextContent(context)),
        const SizedBox(width: 40),
        Expanded(
          flex: 45,
          child: _buildLottie(context, size: 480),
        ),
      ],
    );
  }

  // ── Narrow layout: Lottie top, text below ─────────────────────────────────
  Widget _buildNarrow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildLottie(context, size: 260)),
        const SizedBox(height: 32),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildLottie(BuildContext context, {required double size}) {
    return LottieWidget(
      asset: LottieAssets.coding,
      width: size,
      height: size,
      fit: BoxFit.contain,
    )
        .animate()
        .fadeIn(duration: 1000.ms, delay: 300.ms)
        .scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1));
  }

  Widget _buildTextContent(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Role label
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

        // Headline
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isNarrow ? 38 : 64,
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

        const SizedBox(height: 28),

        // Summary
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            "I'm ${AppConstants.name} — a Senior Flutter Developer with "
            '${AppConstants.yearsExperience} years shipping production mobile applications. '
            'I specialise in clean architecture, reactive state management, and building '
            'scalable multi-module systems from greenfield to store release.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 600.ms),

        const SizedBox(height: 40),

        // Stats
        Wrap(
          spacing: 32,
          runSpacing: 16,
          children: const [
            _StatItem(value: '5+', label: 'YEARS EXP'),
            _StatItem(value: '10+', label: 'PROJECTS'),
            _StatItem(value: '<0.1%', label: 'CRASH RATE'),
            _StatItem(value: '3', label: 'MENTORED'),
          ],
        ).animate().fadeIn(duration: 800.ms, delay: 800.ms),

        const SizedBox(height: 48),

        // CTA buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _CtaButton(label: 'View Work', onTap: onCtaTap, filled: true),
            _CtaButton(label: 'Get in touch', onTap: onCtaTap, filled: false),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),

        const SizedBox(height: 48),

        // Tech tags
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
    );
  }
}

// ── Stat item ─────────────────────────────────────────────────────────────────

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
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.mutedText,
                letterSpacing: 1.5,
                fontSize: 10,
              ),
        ),
      ],
    );
  }
}

// ── CTA button ────────────────────────────────────────────────────────────────

class _CtaButton extends StatelessWidget {
  const _CtaButton({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, ref, hovered) {
        final accent = context.accentColor;
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            decoration: BoxDecoration(
              color: filled
                  ? (hovered ? AppColors.accentDim : accent)
                  : Colors.transparent,
              border: Border.all(
                color: filled
                    ? Colors.transparent
                    : (hovered ? accent : context.borderColor),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: filled
                        ? context.bgColor
                        : (hovered ? accent : context.secondaryText),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        );
      },
    );
  }
}
