import 'package:flutter/material.dart';

class ProjectEntity {
  const ProjectEntity({
    required this.title,
    required this.description,
    required this.tags,
    required this.bullets,
    this.icon = Icons.phone_android,
    this.storeRating,
  });

  final String title;
  final String description;
  final List<String> tags;
  final List<String> bullets;
  final IconData icon;
  final String? storeRating;
}
