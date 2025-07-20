// lib/data/models/team_model.dart
import '../../domain/entities/team.dart';

class TeamModel extends Team {
  TeamModel({
    required String id,
    required String name,
    required String gameId,
    required String description,
    required String imageUrl,
    required List<String> achievements,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
         id: id,
         name: name,
         gameId: gameId,
         description: description,
         imageUrl: imageUrl,
         achievements: achievements,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      gameId: json['game_id'],
      description: json['description'],
      imageUrl: json['image_url'],
      achievements: List<String>.from(json['achievements']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'game_id': gameId,
      'description': description,
      'image_url': imageUrl,
      'achievements': achievements,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
