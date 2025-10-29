// lib/domain/usecases/reservations/get_user_reservations.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/reservation.dart';
import '../../repositories/reservation_repository.dart';

class GetUserReservations
    implements UseCase<List<Reservation>, GetUserReservationsParams> {
  final ReservationRepository repository;

  GetUserReservations(this.repository);

  @override
  Future<Either<Failure, List<Reservation>>> call(
    GetUserReservationsParams params,
  ) {
    return repository.getUserReservations(params.userId);
  }
}

class GetUserReservationsParams extends Equatable {
  final String userId;

  const GetUserReservationsParams({required this.userId});

  @override
  List<Object> get props => [userId];
}
