// lib/data/datasources/remote/user_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soloesport/core/errors/exceptions.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user, String password);
  Future<UserModel> updateUserProfile(UserModel user);
  Future<bool> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register(UserModel user, String password) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': user.name,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    final response = await client.put(
      Uri.parse('${ApiConstants.baseUrl}/users/${user.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.getToken()}',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
