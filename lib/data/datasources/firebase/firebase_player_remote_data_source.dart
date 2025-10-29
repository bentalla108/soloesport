// lib/data/datasources/remote/firebase_player_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/player_model.dart';

abstract class FirebasePlayerRemoteDataSource {
  Future<List<PlayerModel>> getPlayersByTeam(String teamId);
  Future<List<PlayerModel>> getPlayersByGame(String gameId);
  Future<PlayerModel> getPlayerById(String id);
}

class FirebasePlayerRemoteDataSourceImpl implements FirebasePlayerRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebasePlayerRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<PlayerModel>> getPlayersByTeam(String teamId) async {
    try {
      final querySnapshot = await firestore
          .collection('players')
          .where('team_id', isEqualTo: teamId)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return PlayerModel.fromJson(data);
          })
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
          .where('game_id', isEqualTo: gameId)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return PlayerModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PlayerModel> getPlayerById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('players')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return PlayerModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
}
