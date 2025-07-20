// lib/domain/repositories/tournament_repository.dart
import 'package:dartz/dartz.dart';
import 'package:soloesport/domain/entities/registration_tournement.dart';
import '../entities/tournament.dart';
import '../../core/errors/failures.dart';

abstract class TournamentRepository {
  Future<Either<Failure, List<Tournament>>> getAllTournaments();
  Future<Either<Failure, List<Tournament>>> getUpcomingTournaments();
  Future<Either<Failure, List<Tournament>>> getOngoingTournaments();
  Future<Either<Failure, List<Tournament>>> getPastTournaments();
  Future<Either<Failure, Tournament>> getTournamentById(String id);
  Future<Either<Failure, TournamentRegistration>> registerForTournament(
    TournamentRegistration registration,
  );
  Future<Either<Failure, bool>> cancelRegistration(String registrationId);
}
