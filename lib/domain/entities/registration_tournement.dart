// lib/domain/entities/tournament_registration.dart
class TournamentRegistration {
  final String id;
  final String tournamentId;
  final String userId;
  final String playerName;
  final String playerNickname;
  final String email;
  final String phone;
  final bool hasPaid;
  final DateTime registeredAt;
  final String status; // 'pending', 'confirmed', 'cancelled'

  TournamentRegistration({
    required this.id,
    required this.tournamentId,
    required this.userId,
    required this.playerName,
    required this.playerNickname,
    required this.email,
    required this.phone,
    required this.hasPaid,
    required this.registeredAt,
    required this.status,
  });
}
