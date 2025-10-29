// lib/domain/usecases/reservations/get_available_time_slots.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/reservation_repository.dart';

class GetAvailableTimeSlots
    implements UseCase<List<DateTime>, GetAvailableTimeSlotsParams> {
  final ReservationRepository repository;

  GetAvailableTimeSlots(this.repository);

  @override
  Future<Either<Failure, List<DateTime>>> call(
    GetAvailableTimeSlotsParams params,
  ) {
    return repository.getAvailableTimeSlots(
      params.date,
      params.equipmentType,
      params.quantity,
    );
  }
}

class GetAvailableTimeSlotsParams extends Equatable {
  final DateTime date;
  final String equipmentType;
  final int quantity;

  const GetAvailableTimeSlotsParams({
    required this.date,
    required this.equipmentType,
    required this.quantity,
  });

  @override
  List<Object> get props => [date, equipmentType, quantity];
}
