// Domain layer — pure Dart, no Flutter imports.
// IconData is a Flutter type; we store the codePoint + fontFamily instead
// and resolve it in the presentation layer via ProjectIcon.resolve().
class ProjectEntity {
  const ProjectEntity({
    required this.title,
    required this.description,
    required this.tags,
    required this.bullets,
    this.iconKey = 'phone_android',
    this.storeRating,
  });

  final String title;
  final String description;
  final List<String> tags;
  final List<String> bullets;

  /// Logical icon key resolved by the presentation layer.
  final String iconKey;
  final String? storeRating;
}
