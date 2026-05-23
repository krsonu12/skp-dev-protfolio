class ExperienceEntity {
  const ExperienceEntity({
    required this.company,
    required this.location,
    required this.role,
    required this.period,
    required this.bullets,
    this.projectName,
  });

  final String company;
  final String location;
  final String role;
  final String period;
  final List<String> bullets;
  final String? projectName;
}
