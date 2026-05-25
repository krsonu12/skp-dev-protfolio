import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../../domain/entities/skill_category_entity.dart';
import '../../shared_providers/icon_resolver.dart';
import '../../widgets/animated_section.dart';
import '../../widgets/hover_region.dart';
import '../../widgets/lottie_widget.dart';
import '../../widgets/section_label.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({
    super.key,
    required this.skillCategories,
    required this.highlights,
  });

  final List<SkillCategoryEntity> skillCategories;
  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;
    final isMedium = MediaQuery.of(context).size.width < 1100;

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
          const SectionLabel('SKILLS'),
          const SizedBox(height: 32),
          AnimatedSection(
            key: const ValueKey('skills-headline'),
            child: isNarrow
                ? _buildNarrowHeader(context)
                : _buildWideHeader(context),
          ),
          const SizedBox(height: 64),
          AnimatedSection(
            key: const ValueKey('skills-grid'),
            child: _buildGrid(context, isNarrow, isMedium),
          ),
          const SizedBox(height: 80),
          const SectionLabel('ARCHITECTURE & ENGINEERING HIGHLIGHTS'),
          const SizedBox(height: 32),
          AnimatedSection(
            key: const ValueKey('highlights'),
            // Pre-parse highlights outside build — no string work per frame.
            child: Column(
              children: highlights
                  .asMap()
                  .entries
                  .map((e) => _HighlightItem.parse(e.value, e.key))
                  .toList(),
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
          child: Text(
            'The full\npicture.',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 40,
                ),
          ),
        ),
        // RepaintBoundary isolates Lottie repaints from the rest of the tree.
        RepaintBoundary(
          child: const LottieWidget(
            asset: LottieAssets.skills,
            width: 220,
            height: 220,
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 200.ms)
              .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
        ),
      ],
    );
  }

  Widget _buildNarrowHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'The full\npicture.',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 28,
                ),
          ),
        ),
        RepaintBoundary(
          child: const LottieWidget(
            asset: LottieAssets.skills,
            width: 120,
            height: 120,
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context, bool isNarrow, bool isMedium) {
    final crossAxisCount = isNarrow ? 1 : (isMedium ? 2 : 4);

    if (isNarrow) {
      return Column(
        children: skillCategories
            .map((cat) => Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: _SkillCategoryCard(category: cat),
                ))
            .toList(),
      );
    }

    final rows = <Widget>[];
    for (var i = 0; i < skillCategories.length; i += crossAxisCount) {
      final rowItems = skillCategories.skip(i).take(crossAxisCount).toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowItems.asMap().entries.map((entry) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: entry.key == 0 ? 0 : 1,
                    bottom: 1,
                  ),
                  child: _SkillCategoryCard(category: entry.value),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

// ── Skill card ────────────────────────────────────────────────────────────────

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final SkillCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    // Resolve icon once per build — O(1) map lookup, not in a loop.
    final iconData = IconResolver.resolve(category.iconKey);

    return HoverRegion(
      cursor: MouseCursor.defer,
      builder: (context, ref, hovered) {
        final accent = context.accentColor;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color:
                hovered ? context.surfaceElevatedColor : context.surfaceColor,
            border: Border.all(
              color:
                  hovered ? accent.withValues(alpha: 0.3) : context.borderColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: hovered
                      ? accent.withValues(alpha: 0.12)
                      : context.tagBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  iconData,
                  color: hovered ? accent : context.accentColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                category.category.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: hovered ? accent : context.secondaryText,
                      letterSpacing: 1.5,
                      fontSize: 11,
                    ),
              ),
              const SizedBox(height: 12),
              ...category.skills.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6, right: 8),
                        child: Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: hovered ? accent : context.mutedText,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          s,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Highlight row ─────────────────────────────────────────────────────────────
// String parsing is done once in the factory constructor, not on every build.

class _HighlightItem extends StatelessWidget {
  const _HighlightItem({
    super.key,
    required this.index,
    required this.title,
    required this.body,
    required this.hasTitle,
  });

  /// Parse the raw highlight string once — never inside build().
  factory _HighlightItem.parse(String text, int index) {
    final colonIdx = text.indexOf(' \u2014 '); // ' — '
    final hasTitle = colonIdx != -1;
    return _HighlightItem(
      key: ValueKey('highlight-$index'),
      index: index,
      hasTitle: hasTitle,
      title: hasTitle ? text.substring(0, colonIdx) : '',
      body: hasTitle ? text.substring(colonIdx + 3) : text,
    );
  }

  final int index;
  final String title;
  final String body;
  final bool hasTitle;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      cursor: MouseCursor.defer,
      builder: (context, ref, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: hovered ? context.surfaceElevatedColor : Colors.transparent,
          border: Border(bottom: BorderSide(color: context.borderColor)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '0${index + 1}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: hovered ? context.accentColor : context.mutedText,
                    ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: hasTitle
                  ? RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: '$title \u2014 ',
                            style: TextStyle(
                              color: context.primaryText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: body,
                            style: TextStyle(color: context.secondaryText),
                          ),
                        ],
                      ),
                    )
                  : Text(body, style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
