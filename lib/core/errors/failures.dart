// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class ValidationFailure extends Failure {
  final String message;

  ValidationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

// lib/core/errors/exceptions.dart
class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}
