
// imports...
import 'package:flick_scout/core/model/movie.dart';
import 'package:flick_scout/core/shared_widgets/custom_search_bar.dart';
import 'package:flick_scout/features/movie_search/bloc/movie_search_bloc.dart';
import 'package:flick_scout/features/movie_search/presentation/widgets/error_widget.dart';
import 'package:flick_scout/features/movie_search/presentation/widgets/movie_card.dart';
import 'package:flick_scout/features/movie_search/presentation/widgets/no_results_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/shared_widgets/shimmer_load.dart';
import '../data/repository/movie_repository.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 2.h),
            MovieSearchBar(onChanged: (query) { // provide onChanged callback for SearchBar
              if (query.isEmpty){ // check if query is empty
                context.read<MovieSearchBloc>().add(ResetSearch()); // Add ResetSearch event
              }
            }),
            SizedBox(height: 2.h), // Spacing between search bar and results
            Expanded( // Take up remaining space.
              child:
                  BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {

                  if (state is MovieLoading) {

                    return _buildMovieListShimmer();

                  } else if (state is MovieLoaded) {

                    return _buildMovieList(state.movies);

                  } else if (state is MovieError) {

                    if(state.message.toLowerCase().contains('movie not found')) {
                      return const NoResultsScreenPart();// Show 'no results' widget
                    }else {
                      return ErrorDisplay(message: state.message); // Generic error display.
                    }

                  } else if (state is MovieEmpty) { // Handle the empty state.

                     return const Center(
                        child: Text('Search for a movie!', style: TextStyle(fontSize: 16, color: Colors.grey),),
                     );

                  } else {
                    return const SizedBox.shrink(); // handles other states, for example the MovieInitial
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildMovieListShimmer(){

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust these values
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7),
      itemCount: 6, // Number of shimmer placeholders to show
      itemBuilder: (context, index) => const MovieCardShimmer(),


    );


  }

  Widget _buildMovieList(List<Movie> movies) {

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h), // Add padding.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return MovieCard(movie: movie); // display movie information.
      },

    );

  }
}