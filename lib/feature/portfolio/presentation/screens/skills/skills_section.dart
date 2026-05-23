import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/skill_category_entity.dart';
import '../../widgets/animated_section.dart';
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
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
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

          // Skill grid
          AnimatedSection(
            key: const ValueKey('skills-grid'),
            child: _buildGrid(context, isNarrow, isMedium),
          ),

          const SizedBox(height: 80),

          // Architecture highlights
          const SectionLabel('ARCHITECTURE & ENGINEERING HIGHLIGHTS'),
          const SizedBox(height: 32),
          AnimatedSection(
            key: const ValueKey('highlights'),
            child: Column(
              children: highlights.asMap().entries.map((entry) {
                return _HighlightItem(
                  text: entry.value,
                  index: entry.key,
                );
              }).toList(),
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
      itemBuilder: (context, index) {
        return _SkillCategoryCard(category: skillCategories[index]);
      },
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  const _SkillCategoryCard({required this.category});

  final SkillCategoryEntity category;

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surfaceElevated : AppColors.surface,
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cat.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 12),
            Text(
              cat.category.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color:
                        _hovered ? AppColors.accent : AppColors.textSecondary,
                    letterSpacing: 1.5,
                    fontSize: 11,
                  ),
            ),
            const SizedBox(height: 12),
            ...cat.skills.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  s,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightItem extends StatelessWidget {
  const _HighlightItem({required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Split on first em-dash or colon to get title vs body
    final colonIdx = text.indexOf(' — ');
    final hasTitle = colonIdx != -1;
    final title = hasTitle ? text.substring(0, colonIdx) : '';
    final body = hasTitle ? text.substring(colonIdx + 3) : text;

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index
          SizedBox(
            width: 40,
            child: Text(
              '0${index + 1}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textMuted,
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
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: body,
                          style:
                              const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : Text(
                    body,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ),
        ],
      ),
    );
  }
}
