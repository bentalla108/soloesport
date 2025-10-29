import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object?> get props => [message];
}

// Échecs généraux
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Erreur serveur']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Erreur de cache']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Pas de connexion internet']) : super(message);
}

// Échecs d'authentification
class AuthFailure extends Failure {
  const AuthFailure([String message = 'Erreur d\'authentification']) : super(message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Email ou mot de passe incorrect');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure() : super('Utilisateur non trouvé');
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure() : super('Cet email est déjà utilisé');
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure() : super('Le mot de passe est trop faible');
}

// Échecs de validation
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Données invalides']) : super(message);
}

// Échecs de permissions
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permission refusée']) : super(message);
}

// Échecs de données non trouvées
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Données non trouvées']) : super(message);
}
