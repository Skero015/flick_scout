part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchState {}

class MovieInitial extends MovieSearchState {} // Initial state

class MovieLoading extends MovieSearchState {}

class MovieLoaded extends MovieSearchState {
  final List<Movie> movies;

  MovieLoaded({required this.movies});
}

class MovieDetailLoaded extends MovieSearchState { //For details screen
    final MovieDetail movieDetail;
    MovieDetailLoaded({required this.movieDetail});

}

class MovieError extends MovieSearchState {
  final String message;

  MovieError({required this.message});
}


class MovieEmpty extends MovieSearchState {} // State when no movies are found.