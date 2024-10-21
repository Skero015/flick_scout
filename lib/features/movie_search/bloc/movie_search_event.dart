part of 'movie_search_bloc.dart';  // Make part of bloc file.

@immutable
abstract class MovieSearchEvent {}


class SearchMovies extends MovieSearchEvent {
  final String query;

  SearchMovies({required this.query});
}

// Event to load movie details
class LoadMovieDetails extends MovieSearchEvent {
  final String imdbID;
  LoadMovieDetails({required this.imdbID});

}

class ResetSearch extends MovieSearchEvent { // add event to reset the search
  ResetSearch();
}