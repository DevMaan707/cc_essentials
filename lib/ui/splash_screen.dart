import 'dart:async';
import 'package:cc_essentials/services/shared_preferences/shared_preference_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String mainImage;
  final String? bottomImage;
  final double mainImageSize;
  final double? bottomImageSize;
  final String? textBelowMainImage;
  final Duration delay;
  final bool checkAuth;
  final Widget authSuccessful;
  final Widget authFailed;
  final Future<void> Function()? asyncTask;

  const SplashScreen({
    super.key,
    required this.mainImage,
    this.bottomImage,
    this.mainImageSize = 300,
    this.bottomImageSize,
    this.textBelowMainImage,
    this.delay = const Duration(seconds: 3),
    this.checkAuth = false,
    required this.authSuccessful,
    required this.authFailed,
    this.asyncTask,
  });

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.asyncTask != null) {
        await widget.asyncTask!();
      }
      await Future.delayed(widget.delay);
      if (widget.checkAuth) {
        final isLoggedIn = await _checkAuthStatus();
        final route = isLoggedIn ? widget.authSuccessful : widget.authFailed;
        _navigateTo(route);
      } else {
        _navigateTo(widget.authSuccessful);
      }
    });
  }

  Future<bool> _checkAuthStatus() async {
    final prefs = SharedPreferencesService().isLoggedIn();
    return prefs;
  }

  void _navigateTo(Widget route) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  widget.mainImage,
                  width: widget.mainImageSize,
                  height: widget.mainImageSize,
                ),
                if (widget.textBelowMainImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      widget.textBelowMainImage!,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
          if (widget.bottomImage != null)
            Positioned(
              bottom: 16.0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  widget.bottomImage!,
                  width: widget.bottomImageSize,
                  height: widget.bottomImageSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
