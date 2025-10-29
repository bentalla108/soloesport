// lib/presentation/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/auth/get_current_user.dart';
import '../../../domain/usecases/auth/login_user.dart';
import '../../../domain/usecases/auth/logout_user.dart';
import '../../../domain/usecases/auth/register_user.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/user.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUser(
      LoginParams(email: event.email, password: event.password),
    );

    emit(_handleAuthResult(result));
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await registerUser(
      RegisterParams(user: event.user, password: event.password),
    );

    emit(_handleAuthResult(result));
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await logoutUser(NoParams());

    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await getCurrentUser(NoParams());

    emit(_handleAuthResult(result));
  }

  AuthState _handleAuthResult(Either<Failure, User> result) {
    return result.fold(
      (failure) => AuthError(message: _mapFailureToMessage(failure)),
      (user) => Authenticated(user: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Erreur serveur';
      case CacheFailure _:
        return 'Erreur de cache';
      case NetworkFailure _:
        return 'Pas de connexion internet';
      case AuthFailure _:
        return (failure as AuthFailure).message;
      default:
        return 'Erreur inattendue';
    }
  }
}
