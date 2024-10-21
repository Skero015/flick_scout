import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/movie.dart';
import '../data/model/movie_detail.dart';
import '../data/repository/movie_repository.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieRepository movieRepository;

  MovieSearchBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<SearchMovies>(_onSearchMovies);
    on<LoadMovieDetails>(_onLoadMovieDetails);
    on<ResetSearch>((event, emit) => emit(MovieEmpty()));
  }

  void _onSearchMovies(
    SearchMovies event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(MovieLoading());
    try {
      final result = await movieRepository.searchMovies(event.query, 1);

      if(result == null){
        emit(MovieError(message: "Failed to search movies."));
      } else {

        final errorMessage = result.errorMessage; // checks for any error messages before emitting the state.

        if (errorMessage != null) {

          emit(MovieError(message: errorMessage)); // Display original error if not a specific one.

        } else if (result.movies.isEmpty){ //  check if the movie list is empty

          emit(MovieEmpty());

        } else {

          emit(MovieLoaded(movies: result.movies));

        }

      }
    } catch (e) {
      emit(MovieError(message: 'An unexpected error occurred: $e'));
    }
  }

  void _onLoadMovieDetails(
    LoadMovieDetails event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(MovieLoading());
    try {

      final movieDetail = await movieRepository.getMovieDetails(event.imdbID);
      if (movieDetail == null) {

        emit(MovieError(message: 'Failed to load movie details.'));

      } else {

        emit(MovieDetailLoaded(movieDetail: movieDetail));

      }
    } catch (e) {
      emit(MovieError(message: 'An unexpected error occurred: $e'));
    }
  }
}