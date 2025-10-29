// lib/data/models/player_model.dart
import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  PlayerModel({
    required String id,
    required String name,
    required String nickname,
    required int age,
    required String nationality,
    required String role,
    required String imageUrl,
    required String teamId,
    required String gameId,
    required Map<String, String> stats,
    required Map<String, String> socialLinks,
    List<String>? achievements,
    String? biography,
  }) : super(
         id: id,
         name: name,
         nickname: nickname,
         age: age,
         nationality: nationality,
         role: role,
         imageUrl: imageUrl,
         teamId: teamId,
         gameId: gameId,
         stats: stats,
         socialLinks: socialLinks,
         achievements: achievements,
         biography: biography,
       );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      age: json['age'],
      nationality: json['nationality'],
      role: json['role'],
      imageUrl: json['image_url'],
      teamId: json['team_id'],
      gameId: json['game_id'],
      stats: Map<String, String>.from(json['stats']),
      socialLinks: Map<String, String>.from(json['social_links']),
      achievements:
          json['achievements'] != null
              ? List<String>.from(json['achievements'])
              : null,
      biography: json['biography'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'age': age,
      'nationality': nationality,
      'role': role,
      'image_url': imageUrl,
      'team_id': teamId,
      'game_id': gameId,
      'stats': stats,
      'social_links': socialLinks,
      'achievements': achievements,
      'biography': biography,
    };
  }
}
