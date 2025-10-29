import 'package:flutter/material.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String tournaments = '/tournaments';
  static const String tournamentDetail = '/tournament-detail';
  static const String shop = '/shop';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String reservations = '/reservations';
  static const String reservationForm = '/reservation-form';
  static const String roster = '/roster';
  static const String playerDetail = '/player-detail';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page non trouvée')),
          ),
        );
    }
  }
}
