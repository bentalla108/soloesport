// lib/data/models/tournament_registration_model.dart
import '../../domain/entities/registration_tournement.dart';

class TournamentRegistrationModel extends TournamentRegistration {
  TournamentRegistrationModel({
    required String id,
    required String tournamentId,
    required String userId,
    required String playerName,
    required String playerNickname,
    required String email,
    required String phone,
    required bool hasPaid,
    required DateTime registeredAt,
    required String status,
  }) : super(
         id: id,
         tournamentId: tournamentId,
         userId: userId,
         playerName: playerName,
         playerNickname: playerNickname,
         email: email,
         phone: phone,
         hasPaid: hasPaid,
         registeredAt: registeredAt,
         status: status,
       );

  factory TournamentRegistrationModel.fromJson(Map<String, dynamic> json) {
    return TournamentRegistrationModel(
      id: json['id'],
      tournamentId: json['tournament_id'],
      userId: json['user_id'],
      playerName: json['player_name'],
      playerNickname: json['player_nickname'],
      email: json['email'],
      phone: json['phone'],
      hasPaid: json['has_paid'],
      registeredAt: DateTime.parse(json['registered_at']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tournament_id': tournamentId,
      'user_id': userId,
      'player_name': playerName,
      'player_nickname': playerNickname,
      'email': email,
      'phone': phone,
      'has_paid': hasPaid,
      'registered_at': registeredAt.toIso8601String(),
      'status': status,
    };
  }
}
