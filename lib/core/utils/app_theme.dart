// app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue, // Customize your primary color
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue, // Customize app bar color
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // ... other theme customizations
    );
  }



    static ThemeData get darkTheme {
        return ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.grey,

              titleTextStyle: TextStyle(color: Colors.black)),

        );
    }
}