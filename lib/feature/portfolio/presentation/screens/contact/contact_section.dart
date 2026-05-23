import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../widgets/animated_section.dart';
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
          AnimatedSection(
            key: const ValueKey('contact-headline'),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: isNarrow ? 28 : 40,
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
          const SizedBox(height: 32),
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
          AnimatedSection(
            key: const ValueKey('contact-links'),
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _ContactButton(
                  label: '✉️ EMAIL →',
                  onTap: () => _launch('mailto:${AppConstants.email}'),
                  filled: true,
                ),
                _ContactButton(
                  label: 'COPY EMAIL',
                  onTap: () => _copyEmail(context),
                  filled: false,
                ),
                _ContactButton(
                  label: '🐙 GITHUB →',
                  onTap: () => _launch(AppConstants.github),
                  filled: false,
                ),
                _ContactButton(
                  label: '💼 LINKEDIN →',
                  onTap: () => _launch(AppConstants.linkedIn),
                  filled: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
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
}

class _ContactButton extends StatefulWidget {
  const _ContactButton({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.filled
                ? (_hovered
                    ? context.accentColor.withValues(alpha: 0.85)
                    : accent)
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
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: widget.filled
                      ? context.bgColor
                      : (_hovered ? accent : context.secondaryText),
                  letterSpacing: 1.5,
                ),
          ),
        ),
      ),
    );
  }
}
