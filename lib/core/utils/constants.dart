
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
    static const String baseUrl = 'http://www.omdbapi.com/'; // Base URL.

    static String get apiKey {

        return dotenv.env['API_KEY'] ?? 'API KEY NOT FOUND'; // Access the API key from .env
    }

}