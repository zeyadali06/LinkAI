import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
    textButtonTheme: const TextButtonThemeData(style: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)))),
    appBarTheme: const AppBarTheme(color: Colors.white, foregroundColor: Colors.black),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    hintColor: Colors.grey,
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
    snackBarTheme: const SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white)),
    cardColor: Colors.white,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
    textButtonTheme: const TextButtonThemeData(style: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)))),
    appBarTheme: AppBarTheme(color: ThemeData.dark().scaffoldBackgroundColor, foregroundColor: Colors.white),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    snackBarTheme: const SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white)),
    cardColor: Colors.grey[850],
  );

  static ThemeMode fromString(String value) {
    switch (value) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
