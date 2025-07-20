// lib/data/repositories/tournament_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:soloesport/data/models/registration_tournament_model.dart';
import 'package:soloesport/domain/entities/registration_tournement.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/tournament.dart';
import '../../domain/repositories/tournament_repository.dart';
import '../datasources/local/tournament_local_data_source.dart';
import '../datasources/remote/tournament_remote_data_source.dart';

class TournamentRepositoryImpl implements TournamentRepository {
  final TournamentRemoteDataSource remoteDataSource;
  final TournamentLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TournamentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tournament>>> getAllTournaments() async {
    if (await networkInfo.isConnected) {
      try {
        final tournaments = await remoteDataSource.getAllTournaments();
        localDataSource.cacheTournaments(tournaments);
        return Right(tournaments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTournaments = await localDataSource.getCachedTournaments();
        return Right(localTournaments);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Tournament>>> getUpcomingTournaments() async {
    if (await networkInfo.isConnected) {
      try {
        final tournaments = await remoteDataSource.getUpcomingTournaments();
        return Right(tournaments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTournaments =
            await localDataSource.getCachedUpcomingTournaments();
        return Right(localTournaments);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Tournament>>> getOngoingTournaments() async {
    if (await networkInfo.isConnected) {
      try {
        final tournaments = await remoteDataSource.getOngoingTournaments();
        return Right(tournaments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTournaments =
            await localDataSource.getCachedOngoingTournaments();
        return Right(localTournaments);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Tournament>>> getPastTournaments() async {
    if (await networkInfo.isConnected) {
      try {
        final tournaments = await remoteDataSource.getPastTournaments();
        return Right(tournaments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTournaments =
            await localDataSource.getCachedPastTournaments();
        return Right(localTournaments);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Tournament>> getTournamentById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final tournament = await remoteDataSource.getTournamentById(id);
        return Right(tournament);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTournament = await localDataSource.getTournamentById(id);
        return Right(localTournament);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, TournamentRegistration>> registerForTournament(
    TournamentRegistration registration,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.registerForTournament(
          registration as TournamentRegistrationModel,
        );
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cancelRegistration(
    String registrationId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.cancelRegistration(
          registrationId,
        );
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
