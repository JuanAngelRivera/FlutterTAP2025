import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData? setTheme(int opcTheme) {
    switch (opcTheme) {
      case 0:
        return ThemeData.dark();
      case 1:
        return ThemeData.light();
      case 2:
        final theme = ThemeData.light().copyWith(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.pink,
            onPrimary: Colors.white,
            secondary: Colors.blue,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            surface: Colors.pinkAccent,
            onSurface: Colors.white,
          ),
        );

        return theme;
    }

    /*final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'deltarune',
      useMaterial3: true,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
    );
    final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'deltarune',
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );*/
    return null;
  }
}
