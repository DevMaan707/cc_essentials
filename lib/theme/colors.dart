import 'package:flutter/material.dart';

class GlobalColors {
  static Color primaryColor = Colors.blue;
  static Color accentColor = Colors.blueAccent;
  static final GlobalColors _instance = GlobalColors._internal();
  factory GlobalColors() => _instance;
  GlobalColors._internal();
  void initialize({required Color primary, required Color accent}) {
    primaryColor = primary;
    accentColor = accent;
  }
}
