// lib/data/datasources/local/reservation_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/reservation_model.dart';

abstract class ReservationLocalDataSource {
  Future<List<ReservationModel>> getCachedReservations();
  Future<ReservationModel> getReservationById(String id);
  Future<void> cacheReservations(List<ReservationModel> reservations);
  Future<void> cacheReservation(ReservationModel reservation);
  Future<void> removeReservation(String id);
}

class ReservationLocalDataSourceImpl implements ReservationLocalDataSource {
  final SharedPreferences sharedPreferences;

  ReservationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ReservationModel>> getCachedReservations() {
    final jsonString = sharedPreferences.getString('CACHED_RESERVATIONS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => ReservationModel.fromJson(json)).toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ReservationModel> getReservationById(String id) async {
    try {
      final allReservations = await getCachedReservations();
      final reservation = allReservations.firstWhere((r) => r.id == id);
      return reservation;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheReservations(List<ReservationModel> reservations) {
    return sharedPreferences.setString(
      'CACHED_RESERVATIONS',
      json.encode(
        reservations.map((reservation) => reservation.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheReservation(ReservationModel reservation) async {
    try {
      final reservations = await getCachedReservations();
      final index = reservations.indexWhere((r) => r.id == reservation.id);

      if (index >= 0) {
        // Update existing reservation
        reservations[index] = reservation;
      } else {
        // Add new reservation
        reservations.add(reservation);
      }

      await cacheReservations(reservations);
    } on CacheException {
      // If no reservations are cached yet, create a new list
      await cacheReservations([reservation]);
    }
  }

  @override
  Future<void> removeReservation(String id) async {
    try {
      final reservations = await getCachedReservations();
      final filteredReservations =
          reservations.where((r) => r.id != id).toList();
      await cacheReservations(filteredReservations);
    } on CacheException {
      throw CacheException();
    }
  }
}
