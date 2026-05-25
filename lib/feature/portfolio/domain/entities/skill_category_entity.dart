// Domain layer — pure Dart, no Flutter imports.
class SkillCategoryEntity {
  const SkillCategoryEntity({
    required this.category,
    required this.iconKey,
    required this.skills,
  });

  final String category;

  /// Logical icon key resolved by the presentation layer.
  final String iconKey;
  final List<String> skills;
}
