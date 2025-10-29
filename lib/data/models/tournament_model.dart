import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/tournament.dart';

class TournamentModel extends Tournament {
  const TournamentModel({
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
  );

  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    return TournamentModel(
      id: json['id'],
      name: json['name'],
      game: json['game'],
      gameIcon: json['gameIcon'],
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      location: json['location'],
      isOnline: json['isOnline'],
      registrationFee: json['registrationFee'],
      prizePool: json['prizePool'],
      status: json['status'],
      maxParticipants: json['maxParticipants'],
      currentParticipants: json['currentParticipants'],
      description: json['description'],
      format: json['format'],
      rules: List<String>.from(json['rules']),
      prizes: List<Map<String, dynamic>>.from(json['prizes']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'game': game,
      'gameIcon': gameIcon,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'location': location,
      'isOnline': isOnline,
      'registrationFee': registrationFee,
      'prizePool': prizePool,
      'status': status,
      'maxParticipants': maxParticipants,
      'currentParticipants': currentParticipants,
      'description': description,
      'format': format,
      'rules': rules,
      'prizes': prizes,
      'image': image,
    };
  }
}
