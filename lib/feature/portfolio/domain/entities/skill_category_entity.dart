import 'package:flutter/material.dart';

class SkillCategoryEntity {
  const SkillCategoryEntity({
    required this.category,
    required this.icon,
    required this.skills,
  });

  final String category;
  final IconData icon;
  final List<String> skills;
}
