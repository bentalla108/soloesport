// lib/data/datasources/remote/roster_firebase_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/player_model.dart';
import 'package:soloesport/data/models/team_model.dart';
import 'package:soloesport/data/models/game_model.dart';

abstract class RosterFirebaseDataSource {
  // Players
  Future<List<PlayerModel>> getAllPlayers();
  Future<List<PlayerModel>> getPlayersByTeam(String teamId);
  Future<List<PlayerModel>> getPlayersByGame(String gameId);
  Future<PlayerModel> getPlayerById(String id);
  
  // Teams
  Future<List<TeamModel>> getAllTeams();
  Future<List<TeamModel>> getTeamsByGame(String gameId);
  Future<TeamModel> getTeamById(String id);
  
  // Games
  Future<List<GameModel>> getAllGames();
  Future<GameModel> getGameById(String id);
  
  // Streams
  Stream<List<PlayerModel>> getPlayersStream();
  Stream<List<TeamModel>> getTeamsStream();
}

class RosterFirebaseDataSourceImpl implements RosterFirebaseDataSource {
  final FirebaseFirestore firestore;

  RosterFirebaseDataSourceImpl({required this.firestore});

  // ==================== PLAYERS ====================

  @override
  Future<List<PlayerModel>> getAllPlayers() async {
    try {
      final querySnapshot = await firestore
          .collection('players')
          .where('isActive', isEqualTo: true)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => PlayerModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PlayerModel>> getPlayersByTeam(String teamId) async {
    try {
      final querySnapshot = await firestore
          .collection('players')
          .where('teamId', isEqualTo: teamId)
          .where('isActive', isEqualTo: true)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => PlayerModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PlayerModel>> getPlayersByGame(String gameId) async {
    try {
      final querySnapshot = await firestore
          .collection('players')
          .where('gameId', isEqualTo: gameId)
          .where('isActive', isEqualTo: true)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => PlayerModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PlayerModel> getPlayerById(String id) async {
    try {
      final doc = await firestore.collection('players').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return PlayerModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  // ==================== TEAMS ====================

  @override
  Future<List<TeamModel>> getAllTeams() async {
    try {
      final querySnapshot = await firestore
          .collection('teams')
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => TeamModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TeamModel>> getTeamsByGame(String gameId) async {
    try {
      final querySnapshot = await firestore
          .collection('teams')
          .where('gameId', isEqualTo: gameId)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => TeamModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TeamModel> getTeamById(String id) async {
    try {
      final doc = await firestore.collection('teams').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return TeamModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  // ==================== GAMES ====================

  @override
  Future<List<GameModel>> getAllGames() async {
    try {
      final querySnapshot = await firestore
          .collection('games')
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => GameModel.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<GameModel> getGameById(String id) async {
    try {
      final doc = await firestore.collection('games').doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return GameModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  // ==================== STREAMS ====================

  @override
  Stream<List<PlayerModel>> getPlayersStream() {
    return firestore
        .collection('players')
        .where('isActive', isEqualTo: true)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlayerModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  @override
  Stream<List<TeamModel>> getTeamsStream() {
    return firestore
        .collection('teams')
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TeamModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }
}
