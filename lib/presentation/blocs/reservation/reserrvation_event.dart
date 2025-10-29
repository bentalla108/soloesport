// lib/presentation/blocs/reservation/reservation_event.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/reservation.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

class GetUserReservationsEvent extends ReservationEvent {
  final String userId;

  const GetUserReservationsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GetReservationDetailsEvent extends ReservationEvent {
  final String reservationId;

  const GetReservationDetailsEvent({required this.reservationId});

  @override
  List<Object> get props => [reservationId];
}

class CreateReservationEvent extends ReservationEvent {
  final Reservation reservation;

  const CreateReservationEvent({required this.reservation});

  @override
  List<Object> get props => [reservation];
}

class CancelReservationEvent extends ReservationEvent {
  final String reservationId;

  const CancelReservationEvent({required this.reservationId});

  @override
  List<Object> get props => [reservationId];
}

class GetAvailableTimeSlotsEvent extends ReservationEvent {
  final DateTime date;
  final String equipmentType;
  final int quantity;

  const GetAvailableTimeSlotsEvent({
    required this.date,
    required this.equipmentType,
    required this.quantity,
  });

  @override
  List<Object> get props => [date, equipmentType, quantity];
}
