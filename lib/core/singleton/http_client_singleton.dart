import 'package:http/http.dart' as http;

class HttpClientSingleton {
  static final HttpClientSingleton _instance = HttpClientSingleton._internal();

  late http.Client _client;

  factory HttpClientSingleton() {
    return _instance;
  }

  HttpClientSingleton._internal();

  // Initialize the singleton with a given HTTP client.
  static void init(http.Client client) {
    _instance._client = client; // Initialize the client once.
  }

  // Access the singleton instance's client.
  http.Client get client => _instance._client;
}