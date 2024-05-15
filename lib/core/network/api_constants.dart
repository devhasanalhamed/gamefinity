import 'package:flutter_dotenv/flutter_dotenv.dart';

// Api constants

class ApiConstants {
  /// api key
  static String apiKey = dotenv.env['API_KEY'] ?? 'no_key';

  /// base api
  static String base = dotenv.env['BASE_URL'] ?? 'no_url';

  /// games
  static String games = '/games';
}
