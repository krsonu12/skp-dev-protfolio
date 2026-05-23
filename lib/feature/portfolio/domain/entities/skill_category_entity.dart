class SkillCategoryEntity {
  const SkillCategoryEntity({
    required this.category,
    required this.icon,
    required this.skills,
  });

  final String category;
  final String icon;
  final List<String> skills;
}
