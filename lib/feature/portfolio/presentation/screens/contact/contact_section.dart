import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../widgets/animated_section.dart';
import '../../widgets/hover_region.dart';
import '../../widgets/lottie_widget.dart';
import '../../widgets/section_label.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: AppConstants.email));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email copied to clipboard'),
          backgroundColor: context.surfaceElevatedColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: context.borderColor),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 24 : 80,
        vertical: 100,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.borderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('CONTACT'),
          const SizedBox(height: 32),

          // ── Headline + Lottie ─────────────────────────────────────
          AnimatedSection(
            key: const ValueKey('contact-headline'),
            child: isNarrow
                ? _buildNarrowHeader(context)
                : _buildWideHeader(context),
          ),

          const SizedBox(height: 32),

          // ── Sub-text ──────────────────────────────────────────────
          AnimatedSection(
            key: const ValueKey('contact-sub'),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                'Available for full-time roles in India and remotely. '
                "If your project has interesting problems and a team that cares about quality — let's talk.",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17, height: 1.8),
              ),
            ),
          ),

          const SizedBox(height: 56),

          // ── Action buttons ────────────────────────────────────────
          AnimatedSection(
            key: const ValueKey('contact-links'),
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _ContactButton(
                  label: 'EMAIL',
                  icon: Icons.email_outlined,
                  onTap: () => _launch('mailto:${AppConstants.email}'),
                  filled: true,
                ),
                _ContactButton(
                  label: 'COPY EMAIL',
                  icon: Icons.copy_outlined,
                  onTap: () => _copyEmail(context),
                  filled: false,
                ),
                _ContactButton(
                  label: 'GITHUB',
                  icon: Icons.code,
                  onTap: () => _launch(AppConstants.github),
                  filled: false,
                ),
                _ContactButton(
                  label: 'LINKEDIN',
                  icon: Icons.work_outline,
                  onTap: () => _launch(AppConstants.linkedIn),
                  filled: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),

          // ── Footer ────────────────────────────────────────────────
          AnimatedSection(
            key: const ValueKey('footer'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: context.borderColor),
                const SizedBox(height: 24),
                Text(
                  '© 2026 ${AppConstants.name} · Senior Flutter Developer · India',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: context.mutedText,
                        fontSize: 13,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWideHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 40,
                  ),
              children: [
                const TextSpan(text: "Let's build\n"),
                TextSpan(
                  text: 'something worth building.',
                  style: TextStyle(color: context.accentColor),
                ),
              ],
            ),
          ),
        ),
        // Waving hello Lottie
        LottieWidget(
          asset: LottieAssets.hello,
          width: 200,
          height: 200,
          repeat: true,
        )
            .animate()
            .fadeIn(duration: 800.ms, delay: 300.ms)
            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1)),
      ],
    );
  }

  Widget _buildNarrowHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lottie above headline on narrow
        Center(
          child: LottieWidget(
            asset: LottieAssets.hello,
            width: 140,
            height: 140,
            repeat: true,
          ).animate().fadeIn(duration: 800.ms),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 28,
                ),
            children: [
              const TextSpan(text: "Let's build\n"),
              TextSpan(
                text: 'something worth building.',
                style: TextStyle(color: context.accentColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Contact button ────────────────────────────────────────────────────────────

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, ref, hovered) {
        final accent = context.accentColor;
        final fgColor = filled
            ? context.bgColor
            : (hovered ? accent : context.secondaryText);
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: filled
                  ? (hovered ? accent.withValues(alpha: 0.85) : accent)
                  : Colors.transparent,
              border: Border.all(
                color: filled
                    ? Colors.transparent
                    : (hovered ? accent : context.borderColor),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: fgColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: fgColor,
                        letterSpacing: 1.5,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
