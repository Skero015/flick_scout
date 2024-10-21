import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_scout/core/model/movie.dart';
import 'package:flick_scout/core/shared_widgets/custom_search_bar.dart';
import 'package:flick_scout/core/shared_widgets/shimmer_load.dart';
import 'package:flick_scout/features/movie_search/bloc/movie_search_bloc.dart';
import 'package:flick_scout/features/movie_search/data/repository/movie_repository.dart';
import 'package:flick_scout/features/movie_search/presentation/home_screen.dart';
import 'package:flick_scout/features/movie_search/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:sizer/sizer.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

class MockMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState>
    implements MovieSearchBloc {}

void main() {
  late MockMovieRepository mockMovieRepository;
  late MovieSearchBloc mockMovieSearchBloc;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockMovieSearchBloc = MockMovieSearchBloc();
  });

  // HomeScreen tests
  testWidgets('HomeScreen displays search bar', (tester) async {
    when(() => mockMovieSearchBloc.state).thenReturn(MovieInitial());
    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc,mockMovieRepository, ));
    expect(find.byType(MovieSearchBar), findsOneWidget);
  });

  testWidgets('HomeScreen displays loading indicator when loading', (tester) async {
    when(() => mockMovieSearchBloc.state).thenReturn(MovieLoading());
    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc,mockMovieRepository, ));
    // Expect shimmer loading or any other loading widget you're using.
    expect(find.byType(MovieCardShimmer), findsWidgets); // checks that multiple shimmer widgets are displayed.
  });


  testWidgets('HomeScreen displays error message', (tester) async {
    when(() => mockMovieSearchBloc.state)
        .thenReturn( MovieError(message: 'Test error'));
    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc,mockMovieRepository, ));
    expect(find.text('Test error'), findsOneWidget); // Or expect your ErrorDisplay widget
  });



  testWidgets('HomeScreen displays no results message', (tester) async {
    when(() => mockMovieSearchBloc.state).thenReturn(MovieEmpty());
    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc,mockMovieRepository, ));
    expect(find.text('No movies found.'), findsOneWidget);
  });



  testWidgets('HomeScreen displays movie list', (tester) async {

    final movies = [
      Movie(title: 'Movie 1', year: '2024', imdbID: 'tt00001', poster: null, type: 'movie'),
      Movie(title: 'Movie 2', year: '2023', imdbID: 'tt00002', poster: null, type: 'movie')
    ];
    when(() => mockMovieSearchBloc.state).thenReturn(MovieLoaded(movies: movies));

    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc,mockMovieRepository, ));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);


  });




  // MovieSearchBar tests.
  testWidgets('MovieSearchBar triggers search', (WidgetTester tester) async {
    const testQuery = 'Batman';
    when(() => mockMovieSearchBloc.add(any())).thenReturn(null); // Mock Bloc add method.


    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc,mockMovieRepository, ));
    await tester.enterText(find.byType(TextField), testQuery);
    await tester.testTextInput.receiveAction(TextInputAction.done);


    verify(() => mockMovieSearchBloc.add(SearchMovies(query: testQuery))).called(1);


  });




  // MovieCard tests


  testWidgets('MovieCard navigates to details screen', (WidgetTester tester) async {
    final movie = Movie(title: 'Movie', year: '2023', imdbID: 'tt123', poster: null, type: 'movie');

    when(() => mockMovieSearchBloc.add(any())).thenReturn(null); // mock bloc's add event

    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc, mockMovieRepository, movie: movie)); // use test widget that contains a MovieCard.


    await tester.tap(find.byType(MovieCard)); // tap on the card to trigger navigation.
    await tester.pumpAndSettle(); // allow for navigation to complete.

    // If managing state with bloc.
    verify(() => mockMovieSearchBloc.add(LoadMovieDetails(imdbID: 'tt123'))).called(1);


  });


  testWidgets('MovieCard displays image if URL is valid', (tester) async {


    final movie = Movie(title: 'Movie', year: '2023', imdbID: 'tt123', poster: 'poster_url', type: 'movie'); // use a valid poster_url

    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc, mockMovieRepository,  movie: movie));

    expect(find.byType(CachedNetworkImage), findsOneWidget);


  });


  testWidgets('MovieCard handles null poster url', (tester) async {

    final movie = Movie(title: 'Movie', year: '2023', imdbID: 'tt123', poster: null, type: 'movie');

    await tester.pumpWidget(_buildHomeScreen(mockMovieSearchBloc, mockMovieRepository, movie: movie));

    expect(find.byType(CachedNetworkImage), findsNothing); // no image widget is shown

  });

}

Widget _buildHomeScreen(MovieSearchBloc bloc, MockMovieRepository mockMovieRepository, {Movie? movie}) { // helper widget builder. Can build HomeScreen with or without movies.

  return MaterialApp(
    home: ResponsiveSizer( // Wrap with Sizer for responsiveness
      builder: (context, orientation, deviceType) {

        return MultiRepositoryProvider( // provides the required repositories.

          providers: [

            RepositoryProvider.value(value: mockMovieRepository)

          ],

          child: BlocProvider.value(
            value: bloc,


            child: movie != null // movie parameter is optional, returns different UIs if its present.


                ?  MaterialApp( // contains the required widget tests.
                home: Scaffold(
                    body: MovieCard(movie: movie,)
                )

            )


                : const MaterialApp(home: HomeScreen()),


          ),
        );
      },


    ),


  );

}