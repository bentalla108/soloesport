// lib/core/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = 'https://api.soloesport.sn/v1';

  // API endpoints
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String teamsEndpoint = '/teams';
  static const String playersEndpoint = '/players';
  static const String gamesEndpoint = '/games';
  static const String reservationsEndpoint = '/reservations';
  static const String productsEndpoint = '/products';
  static const String ordersEndpoint = '/orders';
  static const String tournamentsEndpoint = '/tournaments';

  // Auth token helper
  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static String? getToken() {
    return _token;
  }

  static void clearToken() {
    _token = null;
  }
}
