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
  }) {
    return TextStyle(
      fontFamily: font.name,
      fontSize: _scaleFactor(fontSize),
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle bodySmall(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(font: font, fontSize: 12, color: color);
  }

  static TextStyle bodySmallBold(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 12, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle bodyMedium(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(font: font, fontSize: 14, color: color);
  }

  static TextStyle bodyLarge(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(font: font, fontSize: 16, color: color);
  }

  static TextStyle headlineSmall(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 18, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle headlineMedium(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 22, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle headlineLarge(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 28, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle titleSmall(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 20, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle titleMedium(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 24, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle titleLarge(
      {FontFamily font = FontFamily.roboto, Color color = Colors.black}) {
    return textStyle(
        font: font, fontSize: 32, fontWeight: FontWeight.w600, color: color);
  }
}
