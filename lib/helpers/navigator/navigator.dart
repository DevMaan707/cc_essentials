import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void pushReplacementTo(Widget newRoute) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => newRoute),
    );
  }

  static void pushTo(Widget newRoute) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => newRoute),
    );
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }

  static void pushAndRemoveUntil(Widget newRoute, RoutePredicate predicate) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => newRoute),
      predicate,
    );
  }

  static void popUntil(RoutePredicate predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }
}
