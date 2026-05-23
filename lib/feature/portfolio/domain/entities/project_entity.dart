class ProjectEntity {
  const ProjectEntity({
    required this.title,
    required this.description,
    required this.tags,
    required this.bullets,
    this.emoji = '📱',
    this.storeRating,
  });

  final String title;
  final String description;
  final List<String> tags;
  final List<String> bullets;
  final String emoji;
  final String? storeRating;
}
