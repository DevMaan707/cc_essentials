import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final Rx<TextEditingController> controller;

  // Core attributes
  final double width;
  final double height;
  final String? hintText;
  final TextInputType? keyboardType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? fillColor;
  final bool filled;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final int? maxLines;
  final int? minLines;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fillColor,
    this.filled = false,
    this.textStyle,
    this.hintStyle,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: width,
          height: height,
          child: TextField(
            controller: controller.value,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: minLines,
            obscureText: obscureText,
            style: textStyle,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: filled,
              fillColor: fillColor,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey,
                  width: borderWidth ?? 1.0,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth ?? 1.0,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              ),
            ),
          ),
        ));
  }
}
