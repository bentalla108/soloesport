// lib/domain/repositories/reservation_repository.dart
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/reservation.dart';

abstract class ReservationRepository {
  Future<Either<Failure, List<Reservation>>> getUserReservations(String userId);
  Future<Either<Failure, Reservation>> getReservationById(String id);
  Future<Either<Failure, Reservation>> createReservation(
    Reservation reservation,
  );
  Future<Either<Failure, bool>> cancelReservation(String id);
  Future<Either<Failure, List<DateTime>>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  );
}
