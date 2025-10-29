// lib/data/datasources/remote/tournament_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soloesport/core/errors/exceptions.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/registration_tournament_model.dart';
import '../../models/tournement_model.dart';

abstract class TournamentRemoteDataSource {
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

class TournamentRemoteDataSourceImpl implements TournamentRemoteDataSource {
  final http.Client client;

  TournamentRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TournamentModel>> getAllTournaments() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/tournaments'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TournamentModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getUpcomingTournaments() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/tournaments/upcoming'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TournamentModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getOngoingTournaments() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/tournaments/ongoing'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TournamentModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TournamentModel>> getPastTournaments() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/tournaments/past'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TournamentModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TournamentModel> getTournamentById(String id) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/tournaments/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TournamentModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TournamentRegistrationModel> registerForTournament(
    TournamentRegistrationModel registration,
  ) async {
    final response = await client.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/tournaments/${registration.tournamentId}/register',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.getToken()}',
      },
      body: json.encode(registration.toJson()),
    );

    if (response.statusCode == 201) {
      return TournamentRegistrationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelRegistration(String registrationId) async {
    final response = await client.delete(
      Uri.parse(
        '${ApiConstants.baseUrl}/tournament-registrations/$registrationId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
