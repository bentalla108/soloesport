// lib/data/models/tournament_model.dart
import '../../domain/entities/tournament.dart';

class TournamentModel extends Tournament {
  TournamentModel({
    required String id,
    required String name,
    required String game,
    required String gameIcon,
    required DateTime startDate,
    required DateTime endDate,
    required String location,
    required bool isOnline,
    required int registrationFee,
    required int prizePool,
    required String status,
    required int maxParticipants,
    required int currentParticipants,
    required String description,
    required String format,
    required List<String> rules,
    required List<Map<String, dynamic>> prizes,
    required String image,
    String? currentStage,
    String? liveStreamUrl,
    List<Map<String, dynamic>>? results,
    String? highlightsUrl,
  }) : super(
         id: id,
         name: name,
         game: game,
         gameIcon: gameIcon,
         startDate: startDate,
         endDate: endDate,
         location: location,
         isOnline: isOnline,
         registrationFee: registrationFee,
         prizePool: prizePool,
         status: status,
         maxParticipants: maxParticipants,
         currentParticipants: currentParticipants,
         description: description,
         format: format,
         rules: rules,
         prizes: prizes,
         image: image,
         currentStage: currentStage,
         liveStreamUrl: liveStreamUrl,
         results: results,
         highlightsUrl: highlightsUrl,
       );

  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    return TournamentModel(
      id: json['id'],
      name: json['name'],
      game: json['game'],
      gameIcon: json['game_icon'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      location: json['location'],
      isOnline: json['is_online'],
      registrationFee: json['registration_fee'],
      prizePool: json['prize_pool'],
      status: json['status'],
      maxParticipants: json['max_participants'],
      currentParticipants: json['current_participants'],
      description: json['description'],
      format: json['format'],
      rules: List<String>.from(json['rules']),
      prizes: List<Map<String, dynamic>>.from(json['prizes']),
      image: json['image'],
      currentStage: json['current_stage'],
      liveStreamUrl: json['live_stream_url'],
      results:
          json['results'] != null
              ? List<Map<String, dynamic>>.from(json['results'])
              : null,
      highlightsUrl: json['highlights_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'game': game,
      'game_icon': gameIcon,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'location': location,
      'is_online': isOnline,
      'registration_fee': registrationFee,
      'prize_pool': prizePool,
      'status': status,
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'description': description,
      'format': format,
      'rules': rules,
      'prizes': prizes,
      'image': image,
      'current_stage': currentStage,
      'live_stream_url': liveStreamUrl,
      'results': results,
      'highlights_url': highlightsUrl,
    };
  }
}
