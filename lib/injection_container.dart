import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Core
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ========== BLOCS ==========
  // TODO: Enregistrer les BLoCs ici

  // ========== USECASES ==========
  // TODO: Enregistrer les UseCases ici

  // ========== REPOSITORIES ==========
  // TODO: Enregistrer les Repositories ici

  // ========== DATASOURCES ==========
  sl.registerLazySingleton<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  sl.registerLazySingleton<TournamentFirebaseDataSource>(
    () => TournamentFirebaseDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<ShopFirebaseDataSource>(
    () => ShopFirebaseDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<ReservationFirebaseDataSource>(
    () => ReservationFirebaseDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<RosterFirebaseDataSource>(
    () => RosterFirebaseDataSourceImpl(firestore: sl()),
  );

  // ========== CORE ==========
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ========== EXTERNAL ==========
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
