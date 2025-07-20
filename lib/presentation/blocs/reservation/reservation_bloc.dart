// lib/presentation/blocs/reservation/reservation_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soloesport/domain/usecases/reservations/cancel_reservation.dart';
import 'package:soloesport/domain/usecases/reservations/create_reservation.dart';
import 'package:soloesport/domain/usecases/reservations/get_available_time_slots.dart';
import 'package:soloesport/domain/usecases/reservations/get_reservation_by_id.dart';
import 'package:soloesport/domain/usecases/reservations/get_user_reservations.dart';
import 'package:soloesport/presentation/blocs/reservation/reserrvation_event.dart';
import '../../../core/errors/failures.dart';

import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final GetUserReservations getUserReservations;
  final GetReservationById getReservationById;
  final CreateReservation createReservation;
  final CancelReservation cancelReservation;
  final GetAvailableTimeSlots getAvailableTimeSlots;

  ReservationBloc({
    required this.getUserReservations,
    required this.getReservationById,
    required this.createReservation,
    required this.cancelReservation,
    required this.getAvailableTimeSlots,
  }) : super(ReservationInitial()) {
    on<GetUserReservationsEvent>(_onGetUserReservations);
    on<GetReservationDetailsEvent>(_onGetReservationDetails);
    on<CreateReservationEvent>(_onCreateReservation);
    on<CancelReservationEvent>(_onCancelReservation);
    on<GetAvailableTimeSlotsEvent>(_onGetAvailableTimeSlots);
  }

  Future<void> _onGetUserReservations(
    GetUserReservationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoading());

    final result = await getUserReservations(
      GetUserReservationsParams(userId: event.userId),
    );

    result.fold(
      (failure) =>
          emit(ReservationError(message: _mapFailureToMessage(failure))),
      (reservations) =>
          emit(UserReservationsLoaded(reservations: reservations)),
    );
  }

  Future<void> _onGetReservationDetails(
    GetReservationDetailsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoading());

    final result = await getReservationById(
      GetReservationByIdParams(id: event.reservationId),
    );

    result.fold(
      (failure) =>
          emit(ReservationError(message: _mapFailureToMessage(failure))),
      (reservation) => emit(ReservationDetailsLoaded(reservation: reservation)),
    );
  }

  Future<void> _onCreateReservation(
    CreateReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoading());

    final result = await createReservation(
      CreateReservationParams(reservation: event.reservation),
    );

    result.fold(
      (failure) =>
          emit(ReservationError(message: _mapFailureToMessage(failure))),
      (reservation) => emit(ReservationCreated(reservation: reservation)),
    );
  }

  Future<void> _onCancelReservation(
    CancelReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoading());

    final result = await cancelReservation(
      CancelReservationParams(id: event.reservationId),
    );

    result.fold(
      (failure) =>
          emit(ReservationError(message: _mapFailureToMessage(failure))),
      (_) => emit(ReservationCancelled()),
    );
  }

  Future<void> _onGetAvailableTimeSlots(
    GetAvailableTimeSlotsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoading());

    final result = await getAvailableTimeSlots(
      GetAvailableTimeSlotsParams(
        date: event.date,
        equipmentType: event.equipmentType,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (failure) =>
          emit(ReservationError(message: _mapFailureToMessage(failure))),
      (timeSlots) => emit(AvailableTimeSlotsLoaded(timeSlots: timeSlots)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Erreur serveur';
      case CacheFailure _:
        return 'Erreur de cache';
      case NetworkFailure _:
        return 'Pas de connexion internet';
      case ValidationFailure _:
        return (failure as ValidationFailure).message;
      default:
        return 'Erreur inattendue';
    }
  }
}
