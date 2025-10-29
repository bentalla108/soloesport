import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required String id,
    required String name,
    required String nickname,
    required int age,
    required String nationality,
    required String role,
    required String imageUrl,
    required String teamId,
    required String gameId,
    required Map<String, dynamic> stats,
    required Map<String, String> socialLinks,
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
  );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      age: json['age'],
      nationality: json['nationality'],
      role: json['role'],
      imageUrl: json['imageUrl'],
      teamId: json['teamId'],
      gameId: json['gameId'],
      stats: Map<String, dynamic>.from(json['stats'] ?? {}),
      socialLinks: Map<String, String>.from(json['socialLinks'] ?? {}),
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
      'imageUrl': imageUrl,
      'teamId': teamId,
      'gameId': gameId,
      'stats': stats,
      'socialLinks': socialLinks,
    };
  }
}
