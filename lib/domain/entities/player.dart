// lib/domain/entities/player.dart
class Player {
  final String id;
  final String name;
  final String nickname;
  final int age;
  final String nationality;
  final String role;
  final String imageUrl;
  final String teamId;
  final String gameId;
  final Map<String, String> stats;
  final Map<String, String> socialLinks;
  final List<String>? achievements;
  final String? biography;

  Player({
    required this.id,
    required this.name,
    required this.nickname,
    required this.age,
    required this.nationality,
    required this.role,
    required this.imageUrl,
    required this.teamId,
    required this.gameId,
    required this.stats,
    required this.socialLinks,
    this.achievements,
    this.biography,
  });
}
