import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../../domain/entities/experience_entity.dart';
import '../../widgets/animated_section.dart';
import '../../widgets/hover_region.dart';
import '../../widgets/section_label.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.experiences});

  final List<ExperienceEntity> experiences;

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
          const SectionLabel('EXPERIENCE'),
          const SizedBox(height: 32),
          AnimatedSection(
            key: const ValueKey('exp-headline'),
            child: Text(
              "Where I've\nshipped things.",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: isNarrow ? 28 : 40,
                  ),
            ),
          ),
          const SizedBox(height: 64),
          ...experiences.asMap().entries.map(
                (entry) => AnimatedSection(
                  key: ValueKey('exp-${entry.key}'),
                  child: _ExperienceCard(
                    experience: entry.value,
                    isNarrow: isNarrow,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

// ── Card — hover via HoverRegion, zero setState ───────────────────────────────

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.experience,
    required this.isNarrow,
  });

  final ExperienceEntity experience;
  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      cursor: MouseCursor.defer,
      builder: (context, ref, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: hovered ? context.surfaceElevatedColor : Colors.transparent,
            border: Border.all(
              color: hovered ? context.borderColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: isNarrow
              ? _buildNarrow(context, hovered)
              : _buildWide(context, hovered),
        );
      },
    );
  }

  Widget _buildWide(BuildContext context, bool hovered) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            experience.period,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: context.mutedText,
                  letterSpacing: 0.5,
                ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(child: _buildContent(context, hovered)),
      ],
    );
  }

  Widget _buildNarrow(BuildContext context, bool hovered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.period,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.mutedText,
                letterSpacing: 0.5,
              ),
        ),
        const SizedBox(height: 12),
        _buildContent(context, hovered),
      ],
    );
  }

  Widget _buildContent(BuildContext context, bool hovered) {
    final accent = context.accentColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.role,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: hovered ? accent : context.primaryText,
              ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              experience.company,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: context.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              ' · ${experience.location}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: context.mutedText,
                  ),
            ),
          ],
        ),
        if (experience.projectName != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.tagBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              experience.projectName!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: context.tagTextColor,
                    letterSpacing: 0.3,
                  ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        ...experience.bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 12),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    b,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
