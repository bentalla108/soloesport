// lib/domain/usecases/teams/get_all_teams.dart
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team_repository.dart';

class GetAllTeams implements UseCase<List<Team>, NoParams> {
  final TeamRepository repository;

  GetAllTeams(this.repository);

  @override
  Future<Either<Failure, List<Team>>> call(NoParams params) {
    return repository.getAllTeams();
  }
}
