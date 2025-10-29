// lib/data/datasources/remote/tournament_firebase_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/registration_tournament_model.dart';
import 'package:soloesport/data/models/tournement_model.dart';

abstract class TournamentFirebaseDataSource {
  Future<List<TournamentModel>> getAllTournaments();
  Future<List<TournamentModel>> getUpcomingTournaments();
  Future<List<TournamentModel>> getOngoingTournaments();
  Future<List<TournamentModel>> getPastTournaments();
  Future<TournamentModel> getTournamentById(String id);
  Future<TournamentRegistrationModel> registerForTournament(
    TournamentRegistrationModel registration,
  );
  Future<bool> cancelRegistration(String registrationId);
  Stream<List<TournamentModel>> getTournamentsStream();
}

class TournamentFirebaseDataSourceImpl implements TournamentFirebaseDataSource {
  final FirebaseFirestore firestore;

  TournamentFirebaseDataSourceImpl({required this.firestore});

  @override
  Future<List<TournamentModel>> getAllTournaments() async {
    try {
      final querySnapshot = await firestore
          .collection('tournaments')
          .orderBy('startDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TournamentModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getUpcomingTournaments() async {
    try {
      final now = DateTime.now();
      final querySnapshot = await firestore
          .collection('tournaments')
          .where('startDate', isGreaterThan: Timestamp.fromDate(now))
          .where('status', isEqualTo: 'open')
          .orderBy('startDate')
          .get();

      return querySnapshot.docs
          .map((doc) => TournamentModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getOngoingTournaments() async {
    try {
      final now = DateTime.now();
      final querySnapshot = await firestore
          .collection('tournaments')
          .where('startDate', isLessThan: Timestamp.fromDate(now))
          .where('status', isEqualTo: 'ongoing')
          .orderBy('startDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TournamentModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getPastTournaments() async {
    try {
      final now = DateTime.now();
      final querySnapshot = await firestore
          .collection('tournaments')
          .where('endDate', isLessThan: Timestamp.fromDate(now))
          .where('status', isEqualTo: 'completed')
          .orderBy('endDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TournamentModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TournamentModel> getTournamentById(String id) async {
    try {
      final doc = await firestore.collection('tournaments').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return TournamentModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TournamentRegistrationModel> registerForTournament(
    TournamentRegistrationModel registration,
  ) async {
    try {
      // Vérifier si le tournoi existe et n'est pas complet
      final tournamentDoc = await firestore
          .collection('tournaments')
          .doc(registration.tournamentId)
          .get();

      if (!tournamentDoc.exists) {
        throw ServerException();
      }

      final tournament = TournamentModel.fromJson({
        ...tournamentDoc.data()!,
        'id': tournamentDoc.id,
      });

      if (tournament.currentParticipants >= tournament.maxParticipants) {
        throw ValidationException('Le tournoi est complet');
      }

      // Créer l'inscription
      final registrationData = {
        'tournamentId': registration.tournamentId,
        'userId': registration.userId,
        'playerName': registration.playerName,
        'playerNickname': registration.playerNickname,
        'email': registration.email,
        'phone': registration.phone,
        'hasPaid': registration.hasPaid,
        'registeredAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      };

      final docRef = await firestore
          .collection('tournament_registrations')
          .add(registrationData);

      // Incrémenter le nombre de participants
      await firestore
          .collection('tournaments')
          .doc(registration.tournamentId)
          .update({
        'currentParticipants': FieldValue.increment(1),
      });

      // Récupérer l'inscription créée
      final createdDoc = await docRef.get();

      return TournamentRegistrationModel.fromJson({
        ...createdDoc.data()!,
        'id': createdDoc.id,
      });
    } catch (e) {
      if (e is ValidationException) {
        throw e;
      }
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelRegistration(String registrationId) async {
    try {
      // Récupérer l'inscription
      final registrationDoc = await firestore
          .collection('tournament_registrations')
          .doc(registrationId)
          .get();

      if (!registrationDoc.exists) {
        throw ServerException();
      }

      final registration = TournamentRegistrationModel.fromJson({
        ...registrationDoc.data()!,
        'id': registrationDoc.id,
      });

      // Supprimer l'inscription
      await firestore
          .collection('tournament_registrations')
          .doc(registrationId)
          .delete();

      // Décrémenter le nombre de participants
      await firestore
          .collection('tournaments')
          .doc(registration.tournamentId)
          .update({
        'currentParticipants': FieldValue.increment(-1),
      });

      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Stream<List<TournamentModel>> getTournamentsStream() {
    return firestore
        .collection('tournaments')
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TournamentModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }
}
