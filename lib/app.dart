import 'package:flick_scout/core/utils/app_theme.dart';
import 'package:flick_scout/features/movie_search/presentation/home_screen.dart';
import 'package:flick_scout/routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
                       

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Remove debug banner
          title: 'Flick Scout',
          theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme, // Custom theme
          onGenerateRoute: generateRoute, // Custom route generator function
          initialRoute: HomeScreen.routeName, // Set initial route
        );
      }
    );
  }
}