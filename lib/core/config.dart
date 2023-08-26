import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  Config._();

  static String get apiBaseUrl => dotenv.get('API_BASE_URL', fallback: '');

  static String get apiKey => dotenv.get('API_KEY', fallback: '');

  static String get imageBaseUrl => dotenv.get('IMAGE_BASE_URL', fallback: '');
}
