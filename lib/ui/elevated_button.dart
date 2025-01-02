import 'package:cc_essentials/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double enabledBorderRadius;
  final Color enabledBorderColor;
  final Size? fixedSize;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;
  final double elevation;
  final EdgeInsetsGeometry padding;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.enabledBorderRadius = 8.0,
    this.enabledBorderColor = Colors.transparent,
    this.fixedSize,
    this.backgroundColor = Colors.transparent,
    this.disabledBackgroundColor = Colors.grey,
    this.foregroundColor = Colors.white,
    this.disabledForegroundColor = Colors.white54,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    final finalBackgroundColor = backgroundColor == Colors.transparent
        ? GlobalColors.primaryColor
        : backgroundColor;
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return disabledBackgroundColor;
              }
              return finalBackgroundColor;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return disabledForegroundColor;
              }
              return foregroundColor;
            },
          ),
          elevation: WidgetStateProperty.all(elevation),
          fixedSize:
              fixedSize != null ? WidgetStateProperty.all(fixedSize) : null,
          padding: WidgetStateProperty.all(padding),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(enabledBorderRadius),
              side: BorderSide(color: enabledBorderColor),
            ),
          ),
        ),
        child: child);
  }
}
