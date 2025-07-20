// lib/domain/usecases/reservations/get_reservation_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/reservation.dart';
import '../../repositories/reservation_repository.dart';

class GetReservationById
    implements UseCase<Reservation, GetReservationByIdParams> {
  final ReservationRepository repository;

  GetReservationById(this.repository);

  @override
  Future<Either<Failure, Reservation>> call(GetReservationByIdParams params) {
    return repository.getReservationById(params.id);
  }
}

class GetReservationByIdParams extends Equatable {
  final String id;

  const GetReservationByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
