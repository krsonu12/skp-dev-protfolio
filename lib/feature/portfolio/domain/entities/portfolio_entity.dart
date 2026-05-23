import 'experience_entity.dart';
import 'project_entity.dart';
import 'skill_category_entity.dart';

class PortfolioEntity {
  const PortfolioEntity({
    required this.experiences,
    required this.projects,
    required this.skillCategories,
    required this.highlights,
  });

  final List<ExperienceEntity> experiences;
  final List<ProjectEntity> projects;
  final List<SkillCategoryEntity> skillCategories;
  final List<String> highlights;
}
