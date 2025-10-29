// lib/data/models/game_model.dart
import '../../domain/entities/game.dart';

class GameModel extends Game {
  GameModel({
    required String id,
    required String name,
    required String iconUrl,
    required String description,
    required String publisher,
    String? platform,
  }) : super(
         id: id,
         name: name,
         iconUrl: iconUrl,
         description: description,
         publisher: publisher,
         platform: platform,
       );

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      iconUrl: json['icon_url'],
      description: json['description'],
      publisher: json['publisher'],
      platform: json['platform'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_url': iconUrl,
      'description': description,
      'publisher': publisher,
      'platform': platform,
    };
  }
}
