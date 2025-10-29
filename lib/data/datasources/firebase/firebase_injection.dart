// lib/data/datasources/firebase_injection.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:soloesport/data/datasources/firebase/firebase_auth_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_game_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_order_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_player_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_product_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_reservation_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_team_remote_data_source.dart';
import 'package:soloesport/data/datasources/firebase/firebase_tournament_remote_data_source.dart';

final GetIt sl = GetIt.instance;

/// Initialise tous les datasources Firebase
///
/// Appeler cette fonction dans votre injection_container.dart
/// AVANT d'initialiser les repositories
///
/// Exemple:
/// ```dart
/// Future<void> init() async {
///   // Initialiser Firebase d'abord
///   await Firebase.initializeApp();
///
///   // Enregistrer les datasources Firebase
///   await initFirebaseDataSources();
///
///   // Puis enregistrer vos repositories, usecases, etc.
/// }
/// ```
Future<void> initFirebaseDataSources() async {
  // Firebase Core
  sl.registerLazySingleton<firebase_auth.FirebaseAuth>(
    () => firebase_auth.FirebaseAuth.instance,
  );

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Firebase DataSources
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  sl.registerLazySingleton<FirebaseProductRemoteDataSource>(
    () => FirebaseProductRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<FirebaseTournamentRemoteDataSource>(
    () => FirebaseTournamentRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<FirebaseReservationRemoteDataSource>(
    () => FirebaseReservationRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<FirebaseTeamRemoteDataSource>(
    () => FirebaseTeamRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<FirebasePlayerRemoteDataSource>(
    () => FirebasePlayerRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<FirebaseGameRemoteDataSource>(
    () => FirebaseGameRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<FirebaseOrderRemoteDataSource>(
    () => FirebaseOrderRemoteDataSourceImpl(firestore: sl()),
  );
}

/// Exemple de migration d'un repository HTTP vers Firebase
/// 
/// AVANT (HTTP):
/// ```dart
/// sl.registerLazySingleton<AuthRepository>(
///   () => AuthRepositoryImpl(
///     remoteDataSource: sl<AuthRemoteDataSource>(),  // HTTP
///     localDataSource: sl(),
///     networkInfo: sl(),
///   ),
/// );
/// ```
/// 
/// APRÈS (Firebase):
/// ```dart
/// sl.registerLazySingleton<AuthRepository>(
///   () => AuthRepositoryImpl(
///     remoteDataSource: sl<FirebaseAuthRemoteDataSource>(),  // Firebase
///     localDataSource: sl(),
///     networkInfo: sl(),
///   ),
/// );
/// ```
