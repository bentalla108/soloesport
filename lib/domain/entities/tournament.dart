// lib/domain/entities/tournament.dart
class Tournament {
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
  final String status; // 'open', 'ongoing', 'completed', 'closed'
  final int maxParticipants;
  final int currentParticipants;
  final String description;
  final String format;
  final List<String> rules;
  final List<Map<String, dynamic>> prizes;
  final String image;
  final String? currentStage;
  final String? liveStreamUrl;
  final List<Map<String, dynamic>>? results;
  final String? highlightsUrl;

  Tournament({
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
    this.currentStage,
    this.liveStreamUrl,
    this.results,
    this.highlightsUrl,
  });
}
