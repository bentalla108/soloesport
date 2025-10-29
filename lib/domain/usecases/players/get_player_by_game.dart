// lib/domain/usecases/players/get_players_by_game.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetPlayersByGame
    implements UseCase<List<Player>, GetPlayersByGameParams> {
  final PlayerRepository repository;

  GetPlayersByGame(this.repository);

  @override
  Future<Either<Failure, List<Player>>> call(GetPlayersByGameParams params) {
    return repository.getPlayersByGame(params.gameId);
  }
}

class GetPlayersByGameParams extends Equatable {
  final String gameId;

  const GetPlayersByGameParams({required this.gameId});

  @override
  List<Object> get props => [gameId];
}
