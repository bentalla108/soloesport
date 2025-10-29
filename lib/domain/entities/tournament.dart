import 'package:equatable/equatable.dart';

class Tournament extends Equatable {
  final String id;
  final String name;
  final String game;
  final String gameIcon;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final bool isOnline;
  final int registrationFee;
  final int prizePool;
  final String status;
  final int maxParticipants;
  final int currentParticipants;
  final String description;
  final String format;
  final List<String> rules;
  final List<Map<String, dynamic>> prizes;
  final String image;

  const Tournament({
    required this.id,
    required this.name,
    required this.game,
    required this.gameIcon,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.isOnline,
    required this.registrationFee,
    required this.prizePool,
    required this.status,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.description,
    required this.format,
    required this.rules,
    required this.prizes,
    required this.image,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    game,
    gameIcon,
    startDate,
    endDate,
    location,
    isOnline,
    registrationFee,
    prizePool,
    status,
    maxParticipants,
    currentParticipants,
    description,
    format,
    rules,
    prizes,
    image,
  ];
}
