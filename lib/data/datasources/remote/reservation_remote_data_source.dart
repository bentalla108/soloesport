// lib/data/datasources/remote/reservation_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors/failures.dart';
import '../../models/reservation_model.dart';
import '../../../core/constants/api_constants.dart';

abstract class ReservationRemoteDataSource {
  Future<List<ReservationModel>> getUserReservations(String userId);
  Future<ReservationModel> getReservationById(String id);
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<bool> cancelReservation(String id);
  Future<List<DateTime>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  );
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  final http.Client client;

  ReservationRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ReservationModel>> getUserReservations(String userId) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/users/$userId/reservations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ReservationModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ReservationModel> getReservationById(String id) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/reservations/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      return ReservationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ReservationModel> createReservation(
    ReservationModel reservation,
  ) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/reservations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.getToken()}',
      },
      body: json.encode(reservation.toJson()),
    );

    if (response.statusCode == 201) {
      return ReservationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelReservation(String id) async {
    final response = await client.delete(
      Uri.parse('${ApiConstants.baseUrl}/reservations/$id'),
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

  @override
  Future<List<DateTime>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  ) async {
    final formattedDate = date.toIso8601String().split('T')[0];
    final response = await client.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/reservations/available-slots?date=$formattedDate&equipment=$equipmentType&quantity=$quantity',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((slot) => DateTime.parse(slot)).toList();
    } else {
      throw ServerException();
    }
  }
}
