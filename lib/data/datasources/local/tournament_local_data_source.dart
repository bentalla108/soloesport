// lib/data/datasources/local/tournament_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloesport/core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../models/tournement_model.dart';

abstract class TournamentLocalDataSource {
  Future<List<TournamentModel>> getCachedTournaments();
  Future<List<TournamentModel>> getCachedUpcomingTournaments();
  Future<List<TournamentModel>> getCachedOngoingTournaments();
  Future<List<TournamentModel>> getCachedPastTournaments();
  Future<TournamentModel> getTournamentById(String id);
  Future<void> cacheTournaments(List<TournamentModel> tournaments);
}

class TournamentLocalDataSourceImpl implements TournamentLocalDataSource {
  final SharedPreferences sharedPreferences;

  TournamentLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TournamentModel>> getCachedTournaments() {
    final jsonString = sharedPreferences.getString('CACHED_TOURNAMENTS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => TournamentModel.fromJson(json)).toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<TournamentModel>> getCachedUpcomingTournaments() async {
    try {
      final allTournaments = await getCachedTournaments();
      final now = DateTime.now();
      return allTournaments
          .where(
            (tournament) =>
                tournament.startDate.isAfter(now) &&
                tournament.status == 'open',
          )
          .toList();
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<List<TournamentModel>> getCachedOngoingTournaments() async {
    try {
      final allTournaments = await getCachedTournaments();
      final now = DateTime.now();
      return allTournaments
          .where(
            (tournament) =>
                tournament.startDate.isBefore(now) &&
                tournament.endDate.isAfter(now) &&
                tournament.status == 'ongoing',
          )
          .toList();
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<List<TournamentModel>> getCachedPastTournaments() async {
    try {
      final allTournaments = await getCachedTournaments();
      final now = DateTime.now();
      return allTournaments
          .where(
            (tournament) =>
                tournament.endDate.isBefore(now) &&
                tournament.status == 'completed',
          )
          .toList();
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<TournamentModel> getTournamentById(String id) async {
    try {
      final allTournaments = await getCachedTournaments();
      final tournament = allTournaments.firstWhere((t) => t.id == id);
      return tournament;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTournaments(List<TournamentModel> tournaments) {
    return sharedPreferences.setString(
      'CACHED_TOURNAMENTS',
      json.encode(
        tournaments.map((tournament) => tournament.toJson()).toList(),
      ),
    );
  }
}
