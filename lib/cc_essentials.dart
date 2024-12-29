library cc_essentials;

import 'package:flutter/material.dart';
import 'services/shared_preferences/shared_preference_service.dart';
import 'theme/custom_theme.dart';

class CCEssentials {
  static Future<void> initialize({
    required Color primaryColor,
    required Color accentColor,
  }) async {
    await SharedPreferencesService().init();
    CustomTheme.initialize(primary: primaryColor, accent: accentColor);
  }
}
