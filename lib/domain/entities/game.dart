// lib/domain/entities/game.dart
class Game {
  final String id;
  final String name;
  final String iconUrl;
  final String description;
  final String publisher;
  final String? platform;

  Game({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.publisher,
    this.platform,
  });
}
