// lib/domain/usecases/games/get_all_games.dart
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/game.dart';
import '../../repositories/game_repository.dart';

class GetAllGames implements UseCase<List<Game>, NoParams> {
  final GameRepository repository;

  GetAllGames(this.repository);

  @override
  Future<Either<Failure, List<Game>>> call(NoParams params) {
    return repository.getAllGames();
  }
}
