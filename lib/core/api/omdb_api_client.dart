import 'package:flick_scout/core/singleton/http_client_singleton.dart';
import 'package:flick_scout/core/utils/constants.dart';
import 'package:http/http.dart' as http;

class OMDbApiClient {

  final http.Client _client = HttpClientSingleton().client; // Gets the client from the singleton.

  Future<http.Response> searchMovies(String query, int page) async {
      final uri = Uri.parse('${Constants.baseUrl}?s=$query&apikey=${Constants.apiKey}');
      return await _client.get(uri);
  }

  Future<http.Response> getMovieDetails(String imdbID) async {
      final uri = Uri.parse('${Constants.baseUrl}?i=$imdbID&apikey=${Constants.apiKey}');
      return await _client.get(uri);

  }
}