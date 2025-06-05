import 'package:flutter/material.dart';

class AppTheme {
  // Define your custom colors
  static const Color primaryColor = Color(0xFF6e3177);
  static const Color accentColor = Color(0xFF1a93ac);
  static const Color backgroundColor = Color(0xFFD8D7DD);
  static const Color buttonColor = Color(0xFF6e3177);
  static const Color textFieldFillColor = Colors.white;

  // Define your custom theme data
  static ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor, // This now maps to the `primary` color
        secondary: accentColor, // This now maps to the `secondary` color
        surface: backgroundColor, // Replaced `background` with `surface`
        onPrimary: Colors.white, // Color for text/icons on primary color
        onSecondary: Colors.black, // Color for text/icons on secondary color
      ),
      scaffoldBackgroundColor: backgroundColor, // Use scaffold background color
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black87), // Updated text style
        bodyMedium: TextStyle(color: Colors.black54), // Updated text style
        headlineMedium: TextStyle(color: Colors.black, fontSize: 18), // Updated headline style
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: textFieldFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: Colors.black54,
        hintStyle: TextStyle(color: Colors.black38),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,  // Replaced `primary` with `backgroundColor`
          foregroundColor: Colors.white,  // Replaced `onPrimary` with `foregroundColor`
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: buttonColor,  // Replaced `primary` with `foregroundColor`
          side: BorderSide(color: buttonColor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: buttonColor),  // Replaced `primary` with `foregroundColor`
      ),
    );
  }
}
