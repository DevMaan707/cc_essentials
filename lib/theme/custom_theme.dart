import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomTheme {
  static late Color primaryColor;
  static late Color accentColor;
  static late Color lightBackgroundColor;
  static late Color darkBackgroundColor;
  static late Color errorColor;

  static void initialize({
    Color? primary,
    Color? accent,
    Color? lightBackground,
    Color? darkBackground,
    Color? error,
  }) {
    primaryColor = primary ?? Colors.blue;
    accentColor = accent ?? Colors.blueAccent;
    lightBackgroundColor = lightBackground ?? Colors.white;
    darkBackgroundColor = darkBackground ?? Colors.black;
    errorColor = error ?? Colors.red;
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
        color: primaryColor,
      ),
      inputDecorationTheme: _inputDecorationTheme(Brightness.light),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor.withOpacity(0.5),
        selectionHandleColor: primaryColor,
      ),
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
        color: primaryColor,
      ),
      inputDecorationTheme: _inputDecorationTheme(Brightness.dark),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor.withOpacity(0.5),
        selectionHandleColor: primaryColor,
      ),
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

  static Pinput buildPinput({
    int length = 4,
    double fieldWidth = 50.0,
    double fieldHeight = 56.0,
    double borderRadius = 8.0,
    Color? defaultColor,
    Color? focusedColor,
    Color? errorColor,
    Function(String)? onChanged,
  }) {
    return Pinput(
      length: length,
      onChanged: onChanged,
      defaultPinTheme: PinTheme(
        width: fieldWidth,
        height: fieldHeight,
        decoration: BoxDecoration(
          border: Border.all(color: defaultColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: fieldWidth,
        height: fieldHeight,
        decoration: BoxDecoration(
          border: Border.all(color: focusedColor ?? CustomTheme.primaryColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      errorPinTheme: PinTheme(
        width: fieldWidth,
        height: fieldHeight,
        decoration: BoxDecoration(
          border: Border.all(color: errorColor ?? CustomTheme.errorColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
