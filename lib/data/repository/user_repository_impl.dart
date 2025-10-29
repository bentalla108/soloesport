// lib/data/repositories/user_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_data_source.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../models/user_model.dart';
import 'package:soloesport/core/errors/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(email, password);
        localDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(User user, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.register(
          user as UserModel,
          password,
        );
        localDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } on ValidationException catch (e) {
        return Left(ValidationFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getLastLoggedInUser();
      return Right(userModel);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await localDataSource.clearUser();
      return const Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.updateUserProfile(
          user as UserModel,
        );
        localDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.resetPassword(email);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } on ValidationException catch (e) {
        return Left(ValidationFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
