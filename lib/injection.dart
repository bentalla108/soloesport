// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soloesport/data/datasources/remote/user_remote_data_source.dart'
    show AuthRemoteDataSource, AuthRemoteDataSourceImpl;
import 'package:soloesport/data/repository/user_repository_impl.dart';
import 'package:soloesport/domain/repositories/user_repository.dart';
import 'package:soloesport/domain/usecases/auth/get_current_user.dart';
import 'package:soloesport/domain/usecases/auth/login_user.dart';
import 'package:soloesport/domain/usecases/auth/logout_user.dart';
import 'package:soloesport/domain/usecases/auth/register_user.dart';
import 'package:soloesport/domain/usecases/auth/reset_password.dart';
import 'package:soloesport/domain/usecases/auth/update_user_profile.dart';
import 'package:soloesport/domain/usecases/games/get_all_games.dart';
import 'package:soloesport/domain/usecases/games/get_game_by_id.dart';
import 'package:soloesport/domain/usecases/orders/cancel_order.dart';
import 'package:soloesport/domain/usecases/orders/get_order_by_id.dart';
import 'package:soloesport/domain/usecases/orders/get_user_orders.dart';
import 'package:soloesport/domain/usecases/players/get_player_by_game.dart';
import 'package:soloesport/domain/usecases/players/get_player_by_id.dart';
import 'package:soloesport/domain/usecases/players/get_players_by_team.dart';
import 'package:soloesport/domain/usecases/teams/get_all_teams.dart';
import 'package:soloesport/domain/usecases/teams/get_team_by_id.dart';
import 'package:soloesport/domain/usecases/teams/get_teams_by_game.dart';
import 'package:soloesport/presentation/blocs/auth/auth_bloc.dart';

import 'core/network/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  registerAdditionalUseCases();
  // Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUser: sl(),
      registerUser: sl(),
      logoutUser: sl(),
      getCurrentUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}

// Ajout dans lib/injection_container.dart

void registerAdditionalUseCases() {
  // Player use cases
  sl.registerLazySingleton(() => GetPlayersByTeam(sl()));
  sl.registerLazySingleton(() => GetPlayerById(sl()));
  sl.registerLazySingleton(() => GetPlayersByGame(sl()));

  // Team use cases
  sl.registerLazySingleton(() => GetTeamsByGame(sl()));
  sl.registerLazySingleton(() => GetTeamById(sl()));
  sl.registerLazySingleton(() => GetAllTeams(sl()));

  // Game use cases
  sl.registerLazySingleton(() => GetAllGames(sl()));
  sl.registerLazySingleton(() => GetGameById(sl()));

  // Order use cases
  sl.registerLazySingleton(() => GetUserOrders(sl()));
  sl.registerLazySingleton(() => GetOrderById(sl()));
  sl.registerLazySingleton(() => CancelOrder(sl()));

  // Additional Auth use cases
  sl.registerLazySingleton(() => UpdateUserProfile(sl()));
}

void registerAuthUseCases() {
  // Use cases existants
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => UpdateUserProfile(sl()));

  // Nouveau use case
  sl.registerLazySingleton(() => ResetPassword(sl()));
}
