// lib/domain/usecases/players/get_players_by_team.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetPlayersByTeam
    implements UseCase<List<Player>, GetPlayersByTeamParams> {
  final PlayerRepository repository;

  GetPlayersByTeam(this.repository);

  @override
  Future<Either<Failure, List<Player>>> call(GetPlayersByTeamParams params) {
    return repository.getPlayersByTeam(params.teamId);
  }
}

class GetPlayersByTeamParams extends Equatable {
  final String teamId;

  const GetPlayersByTeamParams({required this.teamId});

  @override
  List<Object> get props => [teamId];
}
