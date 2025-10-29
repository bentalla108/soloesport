// lib/domain/usecases/players/get_player_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetPlayerById implements UseCase<Player, GetPlayerByIdParams> {
  final PlayerRepository repository;

  GetPlayerById(this.repository);

  @override
  Future<Either<Failure, Player>> call(GetPlayerByIdParams params) {
    return repository.getPlayerById(params.id);
  }
}

class GetPlayerByIdParams extends Equatable {
  final String id;

  const GetPlayerByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
