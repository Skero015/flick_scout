import 'dart:convert';

import 'package:flick_scout/core/api/omdb_api_client.dart';

import '../../../../core/model/movie.dart';
import '../../../../core/utils/constants.dart';
import '../model/movie_detail.dart';
import '../model/movie_search_result.dart';

class MovieRepository {
  final OMDbApiClient apiClient;

  MovieRepository({required this.apiClient});

  Future<MovieSearchResult?> searchMovies(String query, page) async {
    try {

      final response = await apiClient.searchMovies(query, page);

      if (response.statusCode == 200) {
        final searchResultJson = json.decode(response.body);

        if(searchResultJson['Response'] == 'True'){

          return MovieSearchResult.fromJson(searchResultJson);

        } else if (searchResultJson.containsKey('Error')) {


          return MovieSearchResult(movies: [], errorMessage: searchResultJson['Error']); // Handle other API errors and return the specific message.

        } else {

          return null; // returns null if there are other server issues.

        }

      }

    } catch (e) {

      return null;

    }
    return null;
  }




  Future<MovieDetail?> getMovieDetails(String imdbID) async {
    try {
      if(Constants.apiKey == 'API KEY NOT FOUND'){


        throw Exception("API KEY NOT FOUND. Add your key to .env file");
      }

      final response = await apiClient.getMovieDetails(imdbID);

      if (response.statusCode == 200) {
        final movieDetailJson = json.decode(response.body);
        print(movieDetailJson);

          if(movieDetailJson['Response'] == 'True'){
              return MovieDetail.fromJson(movieDetailJson);
          } else {
            print('API Error: ${movieDetailJson['Error']}'); // Log the api error
            return null;
          }

      } else {
          print('Server Error: ${response.statusCode}'); //Log the error
          return null;
      }

    } catch (e) {
        print('Error getting movie details: $e');
        return null; // Or rethrow if you want the bloc to handle it.
    }
  }
}