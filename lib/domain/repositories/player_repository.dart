// lib/domain/repositories/player_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/player.dart';
import '../../core/errors/failures.dart';

abstract class PlayerRepository {
  Future<Either<Failure, List<Player>>> getPlayersByTeam(String teamId);
  Future<Either<Failure, Player>> getPlayerById(String id);
  Future<Either<Failure, List<Player>>> getPlayersByGame(String gameId);
  Future<Either<Failure, Player>> updatePlayer(Player player);
}
