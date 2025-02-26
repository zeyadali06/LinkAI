import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    hintColor: Colors.grey,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe6e6e6))),
      fillColor: Colors.white,
      suffixIconColor: Colors.grey,
      activeIndicatorBorder: BorderSide(color: Colors.grey),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.grey),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.black),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: WidgetStatePropertyAll(Colors.grey.withValues(alpha: .20)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        overlayColor: WidgetStatePropertyAll(Colors.grey.withValues(alpha: .20)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff2a2a2a),
    iconTheme: const IconThemeData(color: Color(0xff9f9ff8)),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    hintColor: Colors.white.withValues(alpha: .5),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: .2))),
      fillColor: const Color(0xff262626),
      suffixIconColor: Colors.white.withValues(alpha: .5),
      activeIndicatorBorder: const BorderSide(color: Color(0xffe6e6e6)),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.grey),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Color(0xff9f9ff8)),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: WidgetStatePropertyAll(Colors.grey.withValues(alpha: .20)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: const WidgetStatePropertyAll(Color(0xff9f9ff8)),
        overlayColor: WidgetStatePropertyAll(Colors.grey.withValues(alpha: .20)),
      ),
    ),
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
