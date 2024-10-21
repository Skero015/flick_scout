// imports
import '../../../../core/model/movie.dart';

class MovieSearchResult {
  final List<Movie> movies;
  final String? errorMessage; // handles error message if needed.



  MovieSearchResult({
    required this.movies,
    this.errorMessage,
  });



  factory MovieSearchResult.fromJson(Map<String, dynamic> json) {


    return MovieSearchResult(
        movies: (json['Search'] as List?)?.map((movieJson) => Movie.fromJson(movieJson)).toList() ?? [],
        errorMessage: json['Error'] != null ? json['Error'] as String : null // handles if response contains Error field, indicating error message.


    );


  }


  Map<String, dynamic> toJson() => {
    'Search': movies.map((movie) => movie.toJson()).toList(),

  };


// ... rest of MovieSearchResult
}