// lib/data/datasources/remote/firebase_tournament_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/registration_tournament_model.dart';
import '../../models/tournement_model.dart';

abstract class FirebaseTournamentRemoteDataSource {
  Future<List<TournamentModel>> getAllTournaments();
  Future<List<TournamentModel>> getUpcomingTournaments();
  Future<List<TournamentModel>> getOngoingTournaments();
  Future<List<TournamentModel>> getPastTournaments();
  Future<TournamentModel> getTournamentById(String id);
  Future<TournamentRegistrationModel> registerForTournament(
    TournamentRegistrationModel registration,
  );
  Future<bool> cancelRegistration(String registrationId);
}

class FirebaseTournamentRemoteDataSourceImpl implements FirebaseTournamentRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseTournamentRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<TournamentModel>> getAllTournaments() async {
    try {
      final querySnapshot = await firestore
          .collection('tournaments')
          .orderBy('start_date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TournamentModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getUpcomingTournaments() async {
    try {
      final now = Timestamp.now();
      final querySnapshot = await firestore
          .collection('tournaments')
          .where('start_date', isGreaterThan: now)
          .where('status', isEqualTo: 'open')
          .orderBy('start_date', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TournamentModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getOngoingTournaments() async {
    try {
      final now = Timestamp.now();
      final querySnapshot = await firestore
          .collection('tournaments')
          .where('start_date', isLessThanOrEqualTo: now)
          .where('end_date', isGreaterThanOrEqualTo: now)
          .where('status', isEqualTo: 'ongoing')
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TournamentModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getPastTournaments() async {
    try {
      final now = Timestamp.now();
      final querySnapshot = await firestore
          .collection('tournaments')
          .where('end_date', isLessThan: now)
          .where('status', whereIn: ['completed', 'closed'])
          .orderBy('end_date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TournamentModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TournamentModel> getTournamentById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('tournaments')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return TournamentModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TournamentRegistrationModel> registerForTournament(
    TournamentRegistrationModel registration,
  ) async {
    try {
      // Vérifier la capacité du tournoi
      final tournamentDoc = await firestore
          .collection('tournaments')
          .doc(registration.tournamentId)
          .get();

      if (!tournamentDoc.exists) {
        throw ServerException();
      }

      final tournamentData = tournamentDoc.data()!;
      final currentParticipants = tournamentData['current_participants'] ?? 0;
      final maxParticipants = tournamentData['max_participants'];

      if (currentParticipants >= maxParticipants) {
        throw ValidationException('Le tournoi est complet');
      }

      // Créer l'inscription
      final registrationData = registration.toJson();
      registrationData['registered_at'] = FieldValue.serverTimestamp();
      registrationData['status'] = 'pending';

      final docRef = await firestore
          .collection('tournament_registrations')
          .add(registrationData);

      // Mettre à jour le nombre de participants
      await firestore
          .collection('tournaments')
          .doc(registration.tournamentId)
          .update({
        'current_participants': FieldValue.increment(1),
      });

      // Récupérer l'inscription créée
      final createdDoc = await docRef.get();
      final createdData = createdDoc.data()!;
      createdData['id'] = createdDoc.id;

      return TournamentRegistrationModel.fromJson(createdData);
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelRegistration(String registrationId) async {
    try {
      final registrationDoc = await firestore
          .collection('tournament_registrations')
          .doc(registrationId)
          .get();

      if (!registrationDoc.exists) {
        throw ServerException();
      }

      final registrationData = registrationDoc.data()!;
      final tournamentId = registrationData['tournament_id'];

      // Mettre à jour le statut
      await firestore
          .collection('tournament_registrations')
          .doc(registrationId)
          .update({'status': 'cancelled'});

      // Décrémenter le nombre de participants
      await firestore
          .collection('tournaments')
          .doc(tournamentId)
          .update({
        'current_participants': FieldValue.increment(-1),
      });

      return true;
    } catch (e) {
      throw ServerException();
    }
  }
}
