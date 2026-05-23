import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../../domain/entities/skill_category_entity.dart';
import '../../widgets/animated_section.dart';
import '../../widgets/hover_region.dart';
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
            child: Text(
              'The full\npicture.',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: isNarrow ? 28 : 40,
                  ),
            ),
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
            child: Column(
              children: highlights
                  .asMap()
                  .entries
                  .map((e) => _HighlightItem(text: e.value, index: e.key))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, bool isNarrow, bool isMedium) {
    final crossAxisCount = isNarrow ? 1 : (isMedium ? 2 : 4);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: isNarrow ? 3 : 1.2,
      ),
      itemCount: skillCategories.length,
      itemBuilder: (context, index) =>
          _SkillCategoryCard(category: skillCategories[index]),
    );
  }
}

// ── Skill card — hover via HoverRegion, zero setState ────────────────────────

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final SkillCategoryEntity category;

  @override
  Widget build(BuildContext context) {
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
              Text(category.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 12),
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
                  child: Text(
                    s,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                        ),
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

class _HighlightItem extends StatelessWidget {
  const _HighlightItem({required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colonIdx = text.indexOf(' — ');
    final hasTitle = colonIdx != -1;
    final title = hasTitle ? text.substring(0, colonIdx) : '';
    final body = hasTitle ? text.substring(colonIdx + 3) : text;

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.borderColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '0${index + 1}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: context.mutedText,
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
                          text: '$title — ',
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
    );
  }
}
