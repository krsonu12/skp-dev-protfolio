import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
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
    await Clipboard.setData(
      const ClipboardData(text: AppConstants.email),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email copied to clipboard'),
          backgroundColor: AppColors.surfaceElevated,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: AppColors.border),
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
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
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
                children: const [
                  TextSpan(text: "Let's build\n"),
                  TextSpan(
                    text: 'something worth building.',
                    style: TextStyle(color: AppColors.accent),
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
                'If your project has interesting problems and a team that cares about quality — let\'s talk.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 17,
                      height: 1.8,
                    ),
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
                  icon: Icons.email_outlined,
                  label: '✉️ EMAIL →',
                  onTap: () => _launch('mailto:${AppConstants.email}'),
                  filled: true,
                ),
                _ContactButton(
                  icon: Icons.copy_outlined,
                  label: 'COPY EMAIL',
                  onTap: () => _copyEmail(context),
                  filled: false,
                ),
                _ContactButton(
                  icon: Icons.code,
                  label: '🐙 GITHUB →',
                  onTap: () => _launch(AppConstants.github),
                  filled: false,
                ),
                _ContactButton(
                  icon: Icons.work_outline,
                  label: '💼 LINKEDIN →',
                  onTap: () => _launch(AppConstants.linkedIn),
                  filled: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          // Footer
          AnimatedSection(
            key: const ValueKey('footer'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: AppColors.border),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      '© 2026 ${AppConstants.name} · Senior Flutter Developer · India',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                    ),
                  ],
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
    required this.icon,
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final IconData icon;
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
                ? (_hovered ? AppColors.accentDim : AppColors.accent)
                : Colors.transparent,
            border: Border.all(
              color: widget.filled
                  ? Colors.transparent
                  : (_hovered ? AppColors.accent : AppColors.border),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: widget.filled
                      ? AppColors.background
                      : (_hovered ? AppColors.accent : AppColors.textSecondary),
                  letterSpacing: 1.5,
                ),
          ),
        ),
      ),
    );
  }
}
