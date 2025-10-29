// lib/data/datasources/local/user_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/errors/failures.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getLastLoggedInUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearUser();
  Future<bool> isUserLoggedIn();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getLastLoggedInUser() {
    final jsonString = sharedPreferences.getString('CACHED_USER');
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel user) {
    return sharedPreferences.setString(
      'CACHED_USER',
      json.encode(user.toJson()),
    );
  }

  @override
  Future<void> clearUser() {
    return sharedPreferences.remove('CACHED_USER');
  }

  @override
  Future<bool> isUserLoggedIn() {
    final jsonString = sharedPreferences.getString('CACHED_USER');
    return Future.value(jsonString != null);
  }
}
