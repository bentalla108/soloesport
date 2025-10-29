import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final String nickname;
  final int age;
  final String nationality;
  final String role;
  final String imageUrl;
  final String teamId;
  final String gameId;
  final Map<String, dynamic> stats;
  final Map<String, String> socialLinks;

  const Player({
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
  });

  @override
  List<Object?> get props => [
    id,
    name,
    nickname,
    age,
    nationality,
    role,
    imageUrl,
    teamId,
    gameId,
    stats,
    socialLinks,
  ];
}
