import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class DynamicTextTheme {
  static double _scaleFactor(double scale) => scale.sp;

  static TextStyle textStyle({
    required FontFamily font,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none,
    double letterSpacing = 0.0,
    double wordSpacing = 0.0,
  }) {
    return TextStyle(
      fontFamily: font.name,
      fontSize: _scaleFactor(fontSize),
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    );
  }

  static TextStyle bodySmall(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 12,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }

  static TextStyle bodySmallBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 12, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle bodyMedium(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 14,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }

  static TextStyle bodyMediumBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 14, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle bodyLarge(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 16,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }

  static TextStyle bodyLargeBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 16, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle headlineSmall(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 18,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: color);
  }

  static TextStyle headlineSmallBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 18, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle headlineMedium(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 22,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: color);
  }

  static TextStyle headlineMediumBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 22, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle headlineLarge(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 28,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: color);
  }

  static TextStyle headlineLargeBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 28, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle titleSmall(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 20,
        fontWeight: bold ? FontWeight.bold : FontWeight.w600,
        color: color);
  }

  static TextStyle titleSmallBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 20, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle titleMedium(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 24,
        fontWeight: bold ? FontWeight.bold : FontWeight.w600,
        color: color);
  }

  static TextStyle titleMediumBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 24, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle titleLarge(
      {FontFamily font = FontFamily.roboto,
      Color color = Colors.black,
      bool bold = false}) {
    return textStyle(
        font: font,
        fontSize: 32,
        fontWeight: bold ? FontWeight.bold : FontWeight.w600,
        color: color);
  }

  static TextStyle titleLargeBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 32, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle dynamicText({
    FontFamily font = FontFamily.roboto,
    double fontSize = 14,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration decoration = TextDecoration.none,
    double letterSpacing = 0.0,
    double wordSpacing = 0.0,
    TextStyle? otherStyle,
  }) {
    TextStyle baseStyle = textStyle(
      font: font,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    );
    return otherStyle?.copyWith(
          fontFamily: otherStyle.fontFamily ?? baseStyle.fontFamily,
          fontSize: otherStyle.fontSize ?? baseStyle.fontSize,
          fontWeight: otherStyle.fontWeight ?? baseStyle.fontWeight,
          color: otherStyle.color ?? baseStyle.color,
          decoration: otherStyle.decoration ?? baseStyle.decoration,
          letterSpacing: otherStyle.letterSpacing ?? baseStyle.letterSpacing,
          wordSpacing: otherStyle.wordSpacing ?? baseStyle.wordSpacing,
        ) ??
        baseStyle;
  }
}
