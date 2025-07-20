// lib/domain/usecases/teams/get_team_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team_repository.dart';

class GetTeamById implements UseCase<Team, GetTeamByIdParams> {
  final TeamRepository repository;

  GetTeamById(this.repository);

  @override
  Future<Either<Failure, Team>> call(GetTeamByIdParams params) {
    return repository.getTeamById(params.id);
  }
}

class GetTeamByIdParams extends Equatable {
  final String id;

  const GetTeamByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
