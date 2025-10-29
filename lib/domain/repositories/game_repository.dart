// lib/domain/repositories/game_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/game.dart';
import '../../core/errors/failures.dart';

abstract class GameRepository {
  Future<Either<Failure, List<Game>>> getAllGames();
  Future<Either<Failure, Game>> getGameById(String id);
}
