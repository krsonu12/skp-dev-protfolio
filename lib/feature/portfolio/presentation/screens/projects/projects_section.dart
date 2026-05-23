import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../../domain/entities/project_entity.dart';
import '../../widgets/animated_section.dart';
import '../../widgets/hover_region.dart';
import '../../widgets/section_label.dart';
import '../../widgets/skill_tag.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.projects});

  final List<ProjectEntity> projects;

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
          const SectionLabel('PROJECTS'),
          const SizedBox(height: 32),
          AnimatedSection(
            key: const ValueKey('proj-headline'),
            child: Text(
              'Selected\nwork.',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: isNarrow ? 28 : 40,
                  ),
            ),
          ),
          const SizedBox(height: 64),
          ...projects.asMap().entries.map(
                (entry) => AnimatedSection(
                  key: ValueKey('proj-${entry.key}'),
                  child: _ProjectCard(
                    project: entry.value,
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

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.isNarrow});

  final ProjectEntity project;
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
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: context.tagBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(project.icon, color: context.accentColor, size: 24),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(child: _buildContent(context, hovered)),
      ],
    );
  }

  Widget _buildNarrow(BuildContext context, bool hovered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(project.icon, color: context.accentColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                project.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color:
                          hovered ? context.accentColor : context.primaryText,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildContent(context, hovered, hideTitle: true),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool hovered, {
    bool hideTitle = false,
  }) {
    final accent = context.accentColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideTitle) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: hovered ? accent : context.primaryText,
                      ),
                ),
              ),
              if (project.storeRating != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.tagBgColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: accent, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        project.storeRating!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: accent),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        ...project.bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 10),
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
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.tags.map((t) => SkillTag(t, small: true)).toList(),
        ),
      ],
    );
  }
}
