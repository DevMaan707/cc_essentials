import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

enum FontFamily {
  inter,
  montserrat,
  poppins,
  nunito,
  nunitoSans,
  roboto,
  lato,
  openSans;

  String get name {
    switch (this) {
      case FontFamily.inter:
        return 'Inter';
      case FontFamily.montserrat:
        return 'Montserrat';
      case FontFamily.poppins:
        return 'Poppins';
      case FontFamily.nunitoSans:
        return 'NunitoSans';
      case FontFamily.roboto:
        return 'Roboto';
      case FontFamily.lato:
        return 'Lato';
      case FontFamily.openSans:
        return 'OpenSans';
      case FontFamily.nunito:
        return 'Nunito';
    }
  }
}

class CustomTheme {
  static late Color primaryColor;
  static late Color accentColor;
  static late Color lightBackgroundColor;
  static late Color darkBackgroundColor;
  static late Color errorColor;
  static late FontFamily fontFamily;

  static void initialize({
    Color? primary,
    Color? accent,
    Color? lightBackground,
    Color? darkBackground,
    Color? error,
    FontFamily? font,
  }) {
    primaryColor = primary ?? Colors.blue;
    accentColor = accent ?? Colors.blueAccent;
    lightBackgroundColor = lightBackground ?? Colors.white;
    darkBackgroundColor = darkBackground ?? Colors.black;
    errorColor = error ?? Colors.red;
    fontFamily = font ?? FontFamily.roboto;
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
      bodyLarge: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily.name,
        fontWeight: FontWeight.bold,
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

  static Pinput buildReactivePinput({
    required RxString rxValue,
    int length = 4,
    double fieldWidth = 50.0,
    double fieldHeight = 56.0,
    double borderRadius = 8.0,
    Color? defaultColor,
    Color? focusedColor,
    Color? errorColor,
    VoidCallback? onComplete,
  }) {
    return Pinput(
      length: length,
      onChanged: (value) {
        rxValue.value = value;
        if (value.length == length && onComplete != null) {
          onComplete();
        }
      },
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
