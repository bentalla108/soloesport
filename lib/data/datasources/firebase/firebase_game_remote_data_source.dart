// lib/data/datasources/remote/firebase_game_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/game_model.dart';

abstract class FirebaseGameRemoteDataSource {
  Future<List<GameModel>> getAllGames();
  Future<GameModel> getGameById(String id);
}

class FirebaseGameRemoteDataSourceImpl implements FirebaseGameRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseGameRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<GameModel>> getAllGames() async {
    try {
      final querySnapshot = await firestore
          .collection('games')
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return GameModel.fromJson(data);
          })
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<GameModel> getGameById(String id) async {
    try {
      final docSnapshot = await firestore
          .collection('games')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw ServerException();
      }

      final data = docSnapshot.data()!;
      data['id'] = docSnapshot.id;

      return GameModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
}
