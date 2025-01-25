import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static late Color primaryColor;
  static late Color accentColor;
  static late Color lightBackgroundColor;
  static late Color darkBackgroundColor;
  static late Color errorColor;
  static late TextStyle fontStyle;

  static void initialize({
    Color? primary,
    Color? accent,
    Color? lightBackground,
    Color? darkBackground,
    Color? error,
    TextStyle? font,
  }) {
    primaryColor = primary ?? Colors.blue;
    accentColor = accent ?? Colors.blueAccent;
    lightBackgroundColor = lightBackground ?? Colors.white;
    darkBackgroundColor = darkBackground ?? Colors.black;
    errorColor = error ?? Colors.red;
    fontStyle = font ?? GoogleFonts.roboto();
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        error: errorColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accentColor,
      ),
      inputDecorationTheme: _inputDecorationTheme(Brightness.light),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor.withOpacity(0.5),
        selectionHandleColor: primaryColor,
      ),
      textTheme: _getTextTheme(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        error: errorColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accentColor,
      ),
      inputDecorationTheme: _inputDecorationTheme(Brightness.dark),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor.withOpacity(0.5),
        selectionHandleColor: primaryColor,
      ),
      textTheme: _getTextTheme(),
    );
  }

  static TextTheme _getTextTheme() {
    return TextTheme(
      bodyLarge: fontStyle.copyWith(fontWeight: FontWeight.normal),
      bodyMedium: fontStyle.copyWith(fontWeight: FontWeight.normal),
      bodySmall: fontStyle.copyWith(fontWeight: FontWeight.normal),
      headlineSmall: fontStyle.copyWith(fontWeight: FontWeight.w500),
      headlineMedium: fontStyle.copyWith(fontWeight: FontWeight.w500),
      headlineLarge: fontStyle.copyWith(fontWeight: FontWeight.w600),
      titleSmall: fontStyle.copyWith(fontWeight: FontWeight.bold),
      titleMedium: fontStyle.copyWith(fontWeight: FontWeight.bold),
      titleLarge: fontStyle.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(Brightness brightness) {
    final borderColor =
        brightness == Brightness.light ? Colors.grey : Colors.white70;
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorColor),
      ),
    );
  }
}
