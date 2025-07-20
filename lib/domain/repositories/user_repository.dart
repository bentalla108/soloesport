// lib/domain/repositories/user_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(User user, String password);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, User>> updateUserProfile(User user);
  Future<Either<Failure, bool>> resetPassword(String email);
}
