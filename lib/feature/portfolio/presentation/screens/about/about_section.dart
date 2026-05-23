import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../widgets/animated_section.dart';
import '../../widgets/section_label.dart';
import '../../widgets/skill_tag.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _allTags = [
    'Flutter',
    'Dart',
    'BLoC',
    'Clean Architecture',
    'Firebase',
    'REST APIs',
    'AWS',
    'Riverpod',
    'MobX',
    'CI/CD',
    'GitHub Actions',
    'Figma',
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;

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
          const SectionLabel('ABOUT'),
          const SizedBox(height: 32),
          AnimatedSection(
            key: const ValueKey('about-headline'),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: isNarrow ? 28 : 40,
                    ),
                children: [
                  const TextSpan(text: 'Flutter engineer.\n'),
                  TextSpan(
                    text: 'Problem solver.',
                    style: TextStyle(color: context.accentColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          if (isNarrow)
            _buildNarrowLayout(context)
          else
            _buildWideLayout(context),
        ],
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildText(context)),
        const SizedBox(width: 80),
        Expanded(flex: 2, child: _buildTags(context)),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(context),
        const SizedBox(height: 40),
        _buildTags(context),
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return AnimatedSection(
      key: const ValueKey('about-text'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppConstants.summary,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 17, height: 1.8)),
          const SizedBox(height: 24),
          Text(AppConstants.summaryExtra,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 17, height: 1.8)),
          const SizedBox(height: 24),
          Text(
            'I hold a Bachelor of Computer Applications (BCA) from Shri Krishna University, '
            'Chattarpur, MP (2018–2021). Outside of code, I care deeply about developer '
            'experience — enforcing quality, automating repetitive tasks, documenting '
            'architectural decisions, and growing junior engineers.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 17, height: 1.8),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(BuildContext context) {
    return AnimatedSection(
      key: const ValueKey('about-tags'),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _allTags.map((t) => SkillTag(t)).toList(),
      ),
    );
  }
}
