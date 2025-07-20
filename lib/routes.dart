// lib/routes.dart
import 'package:flutter/material.dart';
import 'package:soloesport/presentation/pages/auth/login_page.dart';
import 'package:soloesport/presentation/pages/auth/register_page.dart';
import 'package:soloesport/presentation/pages/reservations/reservation_confirmation_page.dart';
import 'package:soloesport/presentation/pages/roster/player_details_page.dart';
import 'package:soloesport/presentation/pages/shop/product_details_page.dart';
import 'package:soloesport/presentation/pages/tournaments/tournament_details_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/roster/roster_page.dart';
import 'presentation/pages/club_info/club_info_page.dart';
import 'presentation/pages/reservations/reservations_page.dart';
import 'presentation/pages/shop/shop_page.dart';
import 'presentation/pages/tournaments/tournaments_page.dart';
import 'presentation/pages/splash/splash_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String roster = '/roster';
  static const String clubInfo = '/club-info';
  static const String reservations = '/reservations';
  static const String shop = '/shop';
  static const String tournaments = '/tournaments';
  static const String playerDetails = '/player-details';
  static const String productDetails = '/product-details';
  static const String tournamentDetails = '/tournament-details';
  static const String reservationConfirmation = '/reservation-confirmation';
  static const String checkout = '/checkout';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashPage(),
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    roster: (context) => const RosterPage(),
    clubInfo: (context) => const ClubInfoPage(),
    reservations: (context) => const ReservationsPage(),
    shop: (context) => const ShopPage(),
    tournaments: (context) => const TournamentsPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case playerDetails:
        final player = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => PlayerDetailsPage(player: player),
        );
      case productDetails:
        final product = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(product: product),
        );
      case tournamentDetails:
        final tournament = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => TournamentDetailsPage(tournament: tournament),
        );
      case reservationConfirmation:
        final reservation = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ReservationConfirmationPage(reservation: reservation),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page introuvable'))),
        );
    }
  }
}
