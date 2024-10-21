// movie_detail_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_scout/features/movie_search/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/shared_widgets/shimmer_load.dart';
import '../bloc/movie_search_bloc.dart';
import '../data/model/movie_detail.dart';


class MovieDetailScreen extends StatefulWidget {
  static const routeName = '/movie-detail';

  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<MovieSearchBloc, MovieSearchState>(
          builder: (context, state) {
            print(state.toString());
            if (state is MovieInitial) {

              return const MovieDetailShimmer(); // shimmer widget to mimic the Movie Details screen when loading.

            } else if (state is MovieLoading) {

              return const MovieDetailShimmer(); // shimmer widget to mimic the Movie Details screen when loading.

            } else if(state is MovieDetailLoaded) { // state has loaded, so access movie details.

              return _buildDetailContent(state.movieDetail);

            } else if (state is MovieError) { // error occurred during loading

              return ErrorDisplay(message: state.message); // Display error message.

            } else if(state is MovieEmpty) {

              return ErrorDisplay(message: 'Fetch failed'); // Display error message.

            }
            // selectedMovie is initially null when the page loads.
            else {
              // handles other states like MovieInitial or other custom states.
              return const SizedBox.shrink();

            }

          }),
    );
  }



  Widget _buildDetailContent(MovieDetail movieDetail) {

    return Stack(
      children: [
        // Background Image
        SizedBox( // Make sure image covers screen.
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: movieDetail.poster ?? '', // Handle null.
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: MovieDetailShimmer()),
              errorWidget: (context, url, error) => const Icon(Icons.broken_image),
            )
        ),
        // Gradient Overlay

        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, // Gradient starts at top.
                end: Alignment.bottomCenter, // Gradient ends at bottom.
                colors: [Colors.transparent, Colors.black.withOpacity(0.9)],

              )
          ),

        ),

        // Content (Scrolled)

        DraggableScrollableSheet(
          initialChildSize: 0.5, // Initial scrollable height
          maxChildSize: 0.9, // Maximum scrollable height.
          minChildSize: 0.4,
          builder: (context, scrollController) {

            return Container( // background color for scrollable content.
              decoration: const BoxDecoration(
                  color: Color(0xff1C1C1C),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              padding: const EdgeInsets.all(16),

              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between back button and fav.
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h), // Space between Play and title.

                    Text(movieDetail.title, style: TextStyle(fontSize: 22.sp, color: Colors.white, fontWeight: FontWeight.bold)),

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0), // vertical padding
                      child: RichText(

                        text: TextSpan(

                            text: movieDetail.year, // The year.
                            style: TextStyle(fontSize: 16.sp, color: Colors.white38), // default text style

                            children: [
                              const TextSpan(text: ' \u2022 '), // Add bullet point.
                              TextSpan(text: movieDetail.genre, style: TextStyle(fontSize: 16.sp, color: Colors.white38)),

                              const TextSpan(text: ' \u2022 '),
                              TextSpan(text: movieDetail.runtime, style: TextStyle(fontSize: 16.sp, color: Colors.white38)), // add spacing

                            ]
                        ),

                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text("Plot Summary", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),

                    Text(movieDetail.plot, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 5.h),

                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text("Cast", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),

                    // Cast Names
                    _castMembers(movieDetail.actors),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }


  Widget _castMembers(String cast) {

    // Retrieve cast information from movieDetail.
    return Padding(
      padding:  EdgeInsets.only(right: 4.w),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          Text(
            cast,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );

  }

}