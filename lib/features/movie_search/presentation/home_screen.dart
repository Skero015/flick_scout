
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey.shade900], // Dark mode gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 2.h), // Responsive spacing
              MovieSearchBar(onChanged: (query) {
                if (query.isEmpty) {
                  context.read<MovieSearchBloc>().add(ResetSearch()); // Reset search if query is empty
                }
              }),
              SizedBox(height: 2.h), // Spacing between search bar and movie results
              Expanded(
                child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return _buildMovieListShimmer();
                    } else if (state is MovieLoaded) {
                      return _buildMovieList(state.movies);
                    } else if (state is MovieError) {
                      if (state.message.toLowerCase().contains('movie not found')) {
                        return const NoResultsScreenPart(); // Show no results widget
                      } else {
                        return ErrorDisplay(message: state.message); // Show error message
                      }
                    } else if (state is MovieEmpty) {
                      return const Center(
                        child: Text(
                          'Search for a movie!',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink(); // Handle MovieInitial state
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieListShimmer() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two cards in one row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) => const MovieCardShimmer(),
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two movie cards in one row
        childAspectRatio: 0.7, // Adjust aspect ratio as needed
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie); // Display movie card
      },
    );
  }
}
