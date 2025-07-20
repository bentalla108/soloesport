// Structure des dossiers pour l'application Solo Esport en Clean Architecture

/*
solo_esport/
│
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_fonts.dart
│   │   │   └── app_strings.dart
│   │   ├── errors/
│   │   │   └── failures.dart
│   │   ├── network/
│   │   │   └── network_info.dart
│   │   └── utils/
│   │       └── input_validator.dart
│   │
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   └── reservations_local_datasource.dart
│   │   │   └── remote/
│   │   │       ├── auth_remote_datasource.dart
│   │   │       ├── roster_remote_datasource.dart
│   │   │       ├── reservations_remote_datasource.dart
│   │   │       ├── shop_remote_datasource.dart
│   │   │       └── tournaments_remote_datasource.dart
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── player_model.dart
│   │   │   ├── team_model.dart
│   │   │   ├── reservation_model.dart
│   │   │   ├── product_model.dart
│   │   │   └── tournament_model.dart
│   │   └── repositories/
│   │       ├── auth_repository_impl.dart
│   │       ├── roster_repository_impl.dart
│   │       ├── reservations_repository_impl.dart
│   │       ├── shop_repository_impl.dart
│   │       └── tournaments_repository_impl.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── user.dart
│   │   │   ├── player.dart
│   │   │   ├── team.dart
│   │   │   ├── reservation.dart
│   │   │   ├── product.dart
│   │   │   └── tournament.dart
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   ├── roster_repository.dart
│   │   │   ├── reservations_repository.dart
│   │   │   ├── shop_repository.dart
│   │   │   └── tournaments_repository.dart
│   │   └── usecases/
│   │       ├── auth/
│   │       │   ├── login_user.dart
│   │       │   └── register_user.dart
│   │       ├── roster/
│   │       │   └── get_team_roster.dart
│   │       ├── reservations/
│   │       │   ├── make_reservation.dart
│   │       │   └── get_available_slots.dart
│   │       ├── shop/
│   │       │   ├── get_products.dart
│   │       │   └── place_order.dart
│   │       └── tournaments/
│   │           ├── get_tournaments.dart
│   │           └── register_for_tournament.dart
│   │
│   ├── presentation/
│   │   ├── blocs/
│   │   │   ├── auth/
│   │   │   ├── roster/
│   │   │   ├── reservations/
│   │   │   ├── shop/
│   │   │   └── tournaments/
│   │   ├── pages/
│   │   │   ├── home/
│   │   │   ├── auth/
│   │   │   ├── roster/
│   │   │   ├── club_info/
│   │   │   ├── reservations/
│   │   │   ├── shop/
│   │   │   └── tournaments/
│   │   └── widgets/
│   │       ├── common/
│   │       │   ├── solo_app_bar.dart
│   │       │   ├── solo_button.dart
│   │       │   ├── solo_card.dart
│   │       │   └── solo_loading.dart
│   │       ├── home/
│   │       ├── roster/
│   │       ├── reservations/
│   │       ├── shop/
│   │       └── tournaments/
│   │
│   ├── routes.dart
│   ├── injection_container.dart (pour la gestion des dépendances)
│   └── main.dart
│
├── assets/
│   ├── fonts/
│   │   └── ...
│   ├── images/
│   │   └── ...
│   └── icons/
│       └── ...
│
├── pubspec.yaml
└── README.md
*/
