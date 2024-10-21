import 'package:flick_scout/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'core/api/omdb_api_client.dart';
import 'core/singleton/http_client_singleton.dart';
import 'features/movie_search/bloc/movie_search_bloc.dart';
import 'features/movie_search/data/repository/movie_repository.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize the HTTP client singleton
  HttpClientSingleton.init(http.Client());

  runApp(
    MultiRepositoryProvider( // Using MultiRepositoryProvider just incase the app need more providers.
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (context) => MovieRepository(
            apiClient: OMDbApiClient(), // OMDb api client
          ),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (context) => MovieSearchBloc(
            movieRepository: RepositoryProvider.of<MovieRepository>(context),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}