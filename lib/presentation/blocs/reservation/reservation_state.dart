// lib/presentation/blocs/reservation/reservation_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/reservation.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

class ReservationInitial extends ReservationState {}

class ReservationLoading extends ReservationState {}

class UserReservationsLoaded extends ReservationState {
  final List<Reservation> reservations;

  const UserReservationsLoaded({required this.reservations});

  @override
  List<Object> get props => [reservations];
}

class ReservationDetailsLoaded extends ReservationState {
  final Reservation reservation;

  const ReservationDetailsLoaded({required this.reservation});

  @override
  List<Object> get props => [reservation];
}

class ReservationCreated extends ReservationState {
  final Reservation reservation;

  const ReservationCreated({required this.reservation});

  @override
  List<Object> get props => [reservation];
}

class ReservationCancelled extends ReservationState {}

class AvailableTimeSlotsLoaded extends ReservationState {
  final List<DateTime> timeSlots;

  const AvailableTimeSlotsLoaded({required this.timeSlots});

  @override
  List<Object> get props => [timeSlots];
}

class ReservationError extends ReservationState {
  final String message;

  const ReservationError({required this.message});

  @override
  List<Object> get props => [message];
}
