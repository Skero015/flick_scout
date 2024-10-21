import 'package:flick_scout/features/movie_search/presentation/home_screen.dart';
import 'package:flick_scout/features/movie_search/presentation/movie_detail_screen.dart';
import 'package:flutter/material.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case MovieDetailScreen.routeName: // Detail screen route
      return MaterialPageRoute(
          builder: (_) => const MovieDetailScreen()
      );
    default: // Handle unknown routes
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Error: Unknown route')),
        ),
      );
  }
}