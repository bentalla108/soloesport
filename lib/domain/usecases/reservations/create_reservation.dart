// lib/domain/usecases/reservations/create_reservation.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/reservation.dart';
import '../../repositories/reservation_repository.dart';

class CreateReservation
    implements UseCase<Reservation, CreateReservationParams> {
  final ReservationRepository repository;

  CreateReservation(this.repository);

  @override
  Future<Either<Failure, Reservation>> call(CreateReservationParams params) {
    return repository.createReservation(params.reservation);
  }
}

class CreateReservationParams extends Equatable {
  final Reservation reservation;

  const CreateReservationParams({required this.reservation});

  @override
  List<Object> get props => [reservation];
}
