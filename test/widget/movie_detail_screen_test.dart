import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_scout/core/shared_widgets/shimmer_load.dart';
import 'package:flick_scout/features/movie_search/bloc/movie_search_bloc.dart';
import 'package:flick_scout/features/movie_search/data/model/movie_detail.dart';
import 'package:flick_scout/features/movie_search/data/repository/movie_repository.dart';
import 'package:flick_scout/features/movie_search/presentation/movie_detail_screen.dart';
import 'package:flick_scout/features/movie_search/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sizer/sizer.dart';

class MockMovieRepository extends Mock implements MovieRepository {}
class MockMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState> implements MovieSearchBloc {}

void main() {
  late MovieRepository movieRepository;
  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    movieRepository = MockMovieRepository();
    movieSearchBloc = MockMovieSearchBloc();
  });

  group('Movie Detail Screen', () {

    testWidgets(
        'should display shimmer when state is MovieLoading',
            (tester) async {
          when(() => movieSearchBloc.state).thenReturn(MovieLoading());
          await tester.pumpWidget(_buildDetailScreen(movieSearchBloc));

          expect(find.byType(MovieCardShimmer), findsOneWidget);

        }
    );


    testWidgets(
      "should display ErrorDisplay widget when state is MovieError",
          (tester) async {
        when(() => movieSearchBloc.state).thenReturn(MovieError(message: "Error"));
        await tester.pumpWidget(_buildDetailScreen(movieSearchBloc));
        expect(find.byType(ErrorDisplay), findsOneWidget);
      },

    );


    testWidgets(
        'should display movie details when state is MovieDetailLoaded',
            (tester) async {


          const imageUrl = "https://m.media-amazon.com/images/M/MV5BNWE5MGI3MDctMmU5Ni00YzI2LWEzMTQtZGIyZDA5MzQzNDBhXkEyXkFqcGc@._V1_SX300.jpg";
          final movieDetail = MovieDetail(
            title: 'Movie Title',
            year: '2023',
            rated: 'PG-13',
            released: '2023-04-28',
            runtime: '120 min',
            genre: 'Action, Adventure, Sci-Fi',
            director: 'Director Name',
            writer: 'Writer Name',
            actors: 'Actor 1, Actor 2, Actor 3',
            plot: 'Movie plot summary.',
            poster: imageUrl,
            imdbRating: '7.8',
          );
          when(() => movieSearchBloc.state).thenReturn(MovieDetailLoaded(movieDetail: movieDetail));

          await tester.pumpWidget(_buildDetailScreen(movieSearchBloc));

          expect(find.text('Movie Title'), findsOneWidget); // verify data is rendered on screen
          expect(find.text('2023'), findsOneWidget);
          expect(find.text('Movie plot summary.'), findsOneWidget);
          expect(find.byType(CachedNetworkImage), findsOneWidget);


        }
    );

  });

}

Widget _buildDetailScreen(MovieSearchBloc bloc, {String? movieId}) {
  return MaterialApp(
    home: ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: MockMovieRepository())
          ],
          child: BlocProvider.value(
            value: bloc,
            child: const MaterialApp(
              home: MovieDetailScreen(),
            ),

          ),
        );
      },
    ),
  );

}