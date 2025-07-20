// lib/domain/entities/team.dart
class Team {
  final String id;
  final String name;
  final String gameId;
  final String description;
  final String imageUrl;
  final List<String> achievements;
  final DateTime createdAt;
  final DateTime updatedAt;

  Team({
    required this.id,
    required this.name,
    required this.gameId,
    required this.description,
    required this.imageUrl,
    required this.achievements,
    required this.createdAt,
    required this.updatedAt,
  });
}
