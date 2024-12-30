import 'package:cc_essentials/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ReactivePinput extends StatelessWidget {
  final RxString rxValue;
  final int length;
  final double fieldWidth;
  final double fieldHeight;
  final double borderRadius;
  final Color? defaultColor;
  final Color? focusedColor;
  final Color? errorColor;
  final VoidCallback? onComplete;
  final String? Function(String?)? validator;

  const ReactivePinput({
    super.key,
    required this.rxValue,
    this.length = 4,
    this.fieldWidth = 50.0,
    this.fieldHeight = 56.0,
    this.borderRadius = 8.0,
    this.defaultColor,
    this.focusedColor,
    this.errorColor,
    this.onComplete,
    this.validator,
  });
  PinTheme _buildPinTheme(Color color) {
    return PinTheme(
      width: fieldWidth,
      height: fieldHeight,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: length,
      onChanged: (value) {
        rxValue.value = value;
        if (value.length == length && onComplete != null) {
          onComplete!();
        }
      },
      validator: validator,
      defaultPinTheme:
          _buildPinTheme(defaultColor ?? GlobalColors.primaryColor),
      focusedPinTheme:
          _buildPinTheme(focusedColor ?? GlobalColors.primaryColor),
      errorPinTheme: _buildPinTheme(errorColor ?? Colors.red),
    );
  }
}
