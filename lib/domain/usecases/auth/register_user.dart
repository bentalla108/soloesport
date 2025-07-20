// lib/domain/usecases/auth/register_user.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class RegisterUser implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) {
    return repository.register(params.user, params.password);
  }
}

class RegisterParams extends Equatable {
  final User user;
  final String password;

  const RegisterParams({required this.user, required this.password});

  @override
  List<Object> get props => [user, password];
}
