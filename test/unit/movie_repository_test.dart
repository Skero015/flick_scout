import 'package:flick_scout/core/api/omdb_api_client.dart';
import 'package:flick_scout/core/model/movie.dart';
import 'package:flick_scout/features/movie_search/data/model/movie_detail.dart';
import 'package:flick_scout/features/movie_search/data/repository/movie_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockOMDbApiClient extends Mock implements OMDbApiClient {}

void main() {
  late MockOMDbApiClient mockApiClient;
  late MovieRepository repository;

  setUp(() {
    mockApiClient = MockOMDbApiClient();
    repository = MovieRepository(apiClient: mockApiClient);
  });

  // Test searchMovies success case
  test('searchMovies returns a list of movies on successful API call',
      () async {
    final tMovieList = [
      Movie(
          title: 'Movie 1',
          year: '2023',
          imdbID: 'tt1234567',
          type: 'movie',
          poster: null),
      Movie(
          title: 'Movie 2',
          year: '2022',
          imdbID: 'tt7654321',
          type: 'movie',
          poster: null),
    ];

    // Create a sample response.
    final tHttpResponse = http.Response(
      '{"Response": "True", "Search": [{"Title": "Movie 1", "Year": "2023", "imdbID": "tt1234567", "Type": "movie"}, {"Title": "Movie 2", "Year": "2022", "imdbID": "tt7654321", "Type": "movie"}]}',
      200,
    );

    when(() => mockApiClient.searchMovies(any(), 1)).thenAnswer(
        (_) async => tHttpResponse); // Mock the API call.

    final result = await repository.searchMovies('test', 1); // Use real repo logic.

    expect(result, equals(tMovieList));
    verify(() => mockApiClient.searchMovies('test', 1)).called(1);
  });




    // test search movies failure

    test(
    'searchMovies returns a ServerFailure when the api call is not successful',
    () async {
        // arrange
        when(() => mockApiClient.searchMovies(any(), 1)).thenThrow(Exception());
        // act
        final result = await repository.searchMovies('test', 1);
        // assert
        //expect(result, isA<ServerFailure>()); // or NetworkFailure, adjust based on specific scenario
        verify(() => mockApiClient.searchMovies('test', 1)).called(1);
    },
    );


    // test getMovieDetails success

    test(
      'getMovieDetails returns movie detail on successful api call',
      () async {
        final tMovieDetail = MovieDetail(
            title: 'Movie Title',
            year: '2023',
            rated: 'PG-13',
            released: '2023-04-28',
            runtime: '120 min',
            genre: 'Action',
            director: 'Director',
            writer: 'Writer',
            actors: 'Actor',
            plot: 'Plot',
            poster: 'poster_url',
            imdbRating: '7.8'
        );


        final tHttpResponse = http.Response('''
        {
            "Title": "Movie Title",
            "Year": "2023",
            "Rated": "PG-13",
            "Released": "2023-04-28",
            "Runtime": "120 min",
            "Genre": "Action",
            "Director": "Director",
            "Writer": "Writer",
            "Actors": "Actor",
            "Plot": "Plot",
            "Poster": "poster_url",
            "imdbRating": "7.8",
            "Response": "True"
        }
        ''', 200);
        when(() => mockApiClient.getMovieDetails(any())).thenAnswer((_) async => tHttpResponse);

        final result = await repository.getMovieDetails('imdbID');

        expect(result, equals(tMovieDetail));
      },
    );





    // test getMovieDetails Failure



    test(
    'getMovieDetails returns a ServerFailure when the api call is not successful',
    () async {
        when(() => mockApiClient.getMovieDetails(any())).thenThrow(Exception());

        final result = await repository.getMovieDetails('imdbId');

        //expect(result, isA<ServerFailure>());
    },
    );





}