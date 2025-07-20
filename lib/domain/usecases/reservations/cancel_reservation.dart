// lib/domain/usecases/reservations/cancel_reservation.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/reservation_repository.dart';

class CancelReservation implements UseCase<bool, CancelReservationParams> {
  final ReservationRepository repository;

  CancelReservation(this.repository);

  @override
  Future<Either<Failure, bool>> call(CancelReservationParams params) {
    return repository.cancelReservation(params.id);
  }
}

class CancelReservationParams extends Equatable {
  final String id;

  const CancelReservationParams({required this.id});

  @override
  List<Object> get props => [id];
}
