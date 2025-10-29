// lib/domain/usecases/games/get_game_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/game.dart';
import '../../repositories/game_repository.dart';

class GetGameById implements UseCase<Game, GetGameByIdParams> {
  final GameRepository repository;

  GetGameById(this.repository);

  @override
  Future<Either<Failure, Game>> call(GetGameByIdParams params) {
    return repository.getGameById(params.id);
  }
}

class GetGameByIdParams extends Equatable {
  final String id;

  const GetGameByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
