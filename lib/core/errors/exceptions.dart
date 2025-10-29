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
