import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/project_entity.dart';
import '../../widgets/animated_section.dart';
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
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
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
          ...projects.asMap().entries.map((entry) {
            return AnimatedSection(
              key: ValueKey('proj-${entry.key}'),
              child: _ProjectCard(
                project: entry.value,
                isNarrow: isNarrow,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.isNarrow});

  final ProjectEntity project;
  final bool isNarrow;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surfaceElevated : Colors.transparent,
          border: Border.all(
            color: _hovered ? AppColors.border : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            widget.isNarrow ? _buildNarrow(context, p) : _buildWide(context, p),
      ),
    );
  }

  Widget _buildWide(BuildContext context, ProjectEntity p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Emoji icon
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.tagBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(p.emoji, style: const TextStyle(fontSize: 24)),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(child: _buildContent(context, p)),
      ],
    );
  }

  Widget _buildNarrow(BuildContext context, ProjectEntity p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(p.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                p.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color:
                          _hovered ? AppColors.accent : AppColors.textPrimary,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildContent(context, p, hideTitle: true),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProjectEntity p, {
    bool hideTitle = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideTitle) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  p.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color:
                            _hovered ? AppColors.accent : AppColors.textPrimary,
                      ),
                ),
              ),
              if (p.storeRating != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.tagBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: AppColors.accent, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        p.storeRating!,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.accent,
                                ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Text(
          p.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 16),
        // Bullets
        ...p.bullets.map(
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
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
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
        // Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: p.tags.map((t) => SkillTag(t, small: true)).toList(),
        ),
      ],
    );
  }
}
