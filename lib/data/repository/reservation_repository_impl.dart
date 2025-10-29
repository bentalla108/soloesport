// lib/data/repositories/reservation_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import 'package:soloesport/core/errors/exceptions.dart';

import '../../core/network/network_info.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/local/reservation_local_data_source.dart';
import '../datasources/remote/reservation_remote_data_source.dart';
import '../models/reservation_model.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource remoteDataSource;
  final ReservationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ReservationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Reservation>>> getUserReservations(
    String userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final reservations = await remoteDataSource.getUserReservations(userId);
        localDataSource.cacheReservations(reservations);
        return Right(reservations);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localReservations = await localDataSource.getCachedReservations();
        return Right(localReservations);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Reservation>> getReservationById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final reservation = await remoteDataSource.getReservationById(id);
        return Right(reservation);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localReservation = await localDataSource.getReservationById(id);
        return Right(localReservation);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Reservation>> createReservation(
    Reservation reservation,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final createdReservation = await remoteDataSource.createReservation(
          reservation as ReservationModel,
        );
        await localDataSource.cacheReservation(createdReservation);
        return Right(createdReservation);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cancelReservation(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.cancelReservation(id);
        if (result) {
          await localDataSource.removeReservation(id);
        }
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<DateTime>>> getAvailableTimeSlots(
    DateTime date,
    String equipmentType,
    int quantity,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final timeSlots = await remoteDataSource.getAvailableTimeSlots(
          date,
          equipmentType,
          quantity,
        );
        return Right(timeSlots);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
