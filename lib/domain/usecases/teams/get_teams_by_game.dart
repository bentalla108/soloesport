// lib/domain/usecases/teams/get_teams_by_game.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team_repository.dart';

class GetTeamsByGame implements UseCase<List<Team>, GetTeamsByGameParams> {
  final TeamRepository repository;

  GetTeamsByGame(this.repository);

  @override
  Future<Either<Failure, List<Team>>> call(GetTeamsByGameParams params) {
    return repository.getTeamsByGame(params.gameId);
  }
}

class GetTeamsByGameParams extends Equatable {
  final String gameId;

  const GetTeamsByGameParams({required this.gameId});

  @override
  List<Object> get props => [gameId];
}
