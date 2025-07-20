// lib/domain/usecases/auth/update_user_profile.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class UpdateUserProfile implements UseCase<User, UpdateUserProfileParams> {
  final AuthRepository repository;

  UpdateUserProfile(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserProfileParams params) {
    return repository.updateUserProfile(params.user);
  }
}

class UpdateUserProfileParams extends Equatable {
  final User user;

  const UpdateUserProfileParams({required this.user});

  @override
  List<Object> get props => [user];
}

// Mise à jour du fichier d'injection de dépendances pour inclure ces nouveaux use cases
