import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_scout/core/model/movie.dart';
import 'package:flick_scout/core/shared_widgets/shimmer_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/movie_search_bloc.dart';
import '../movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // Dismiss keyboard
          context.read<MovieSearchBloc>().add(LoadMovieDetails(imdbID: movie.imdbID)); // Emit event
          Navigator.pushNamed(context, MovieDetailScreen.routeName); // Navigate to detail page
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image (movie poster)
            if (movie.poster != null)
              CachedNetworkImage(
                imageUrl: movie.poster!,
                fit: BoxFit.cover, // Cover entire card
                placeholder: (context, url) => const Center(child: MovieCardShimmer()), // Placeholder while loading
                errorWidget: (context, url, error) => const Icon(Icons.error), // Error handling
              ),

            // Color gradient overlay for the effect
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            // Foreground content (text and movie details)
            Padding(
              padding: EdgeInsets.all(8.0), // Adjust padding as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Align text to bottom
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white, // Text color to stand out on gradient
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Handle long titles
                  ),
                  const SizedBox(height: 4.0), // Space between title and other text
                  Text(
                    '${movie.year} • ${movie.type}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7), // Lighter color for subtitle
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
