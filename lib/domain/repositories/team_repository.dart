// lib/domain/repositories/team_repository.dart (suite)
import 'package:dartz/dartz.dart';
import '../entities/team.dart';
import '../../core/errors/failures.dart';

abstract class TeamRepository {
  Future<Either<Failure, List<Team>>> getTeamsByGame(String gameId);
  Future<Either<Failure, Team>> getTeamById(String id);
  Future<Either<Failure, List<Team>>> getAllTeams();
  Future<Either<Failure, Team>> updateTeam(Team team);
}
