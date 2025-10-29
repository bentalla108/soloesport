// lib/data/datasources/remote/firebase_team_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/team_model.dart';

abstract class FirebaseTeamRemoteDataSource {
  Future<List<TeamModel>> getAllTeams();
  Future<List<TeamModel>> getTeamsByGame(String gameId);
  Future<TeamModel> getTeamById(String id);
}

class FirebaseTeamRemoteDataSourceImpl implements FirebaseTeamRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseTeamRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<TeamModel>> getAllTeams() async {
    try {
      final querySnapshot = await firestore
          .collection('teams')
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TeamModel.fromJson(data);
          })
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
          .where('game_id', isEqualTo: gameId)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return TeamModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TeamModel> getTeamById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('teams')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return TeamModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
}
