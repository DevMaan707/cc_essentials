import 'package:cc_essentials/theme/colors.dart';
import 'package:cc_essentials/ui/elevated_button.dart';
import 'package:cc_essentials/ui/pinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpWidget extends StatelessWidget {
  final RxBool isLoading;
  final RxString otpValue;
  final int otpLength;
  final double fieldWidth;
  final double fieldHeight;
  final double borderRadius;
  final Color? defaultColor;
  final Color? focusedColor;
  final Color? errorColor;
  final VoidCallback? onResend;
  final VoidCallback? onRegister;
  final String? Function(String?)? validator;
  final String resendText;
  final String? registerText;
  final bool showRegisterLink;
  final void Function(String)? onComplete;
  final String? title;
  final String? helperText;
  final double? width;
  final double? height;
  final Size? verifySize;

  // Container customizations
  final EdgeInsets? padding;
  final Color? containerColor;
  final BorderRadius? containerBorderRadius;

  // Styling customizations
  final TextStyle? titleTextStyle;
  final TextStyle? helperTextStyle;
  final TextStyle? resendTextStyle;
  final TextStyle? registerTextStyle;

  // Padding between widgets
  final EdgeInsets? padding1; // Between title and helper text
  final EdgeInsets? padding2; // Between helper text and Pinput
  final EdgeInsets? padding3; // Between Pinput and Resend
  final EdgeInsets? padding4; // Between Resend and SignUp

  const OtpWidget({
    super.key,
    required this.otpValue,
    required this.isLoading,
    this.otpLength = 6,
    this.fieldWidth = 50.0,
    this.fieldHeight = 56.0,
    this.borderRadius = 8.0,
    this.defaultColor,
    this.focusedColor,
    this.errorColor,
    this.onResend,
    this.onRegister,
    this.validator,
    this.resendText = "Resend OTP",
    this.registerText = "Verify",
    this.showRegisterLink = false,
    this.onComplete,
    this.padding,
    this.containerColor,
    this.containerBorderRadius,
    this.title = '',
    this.helperText = '',
    this.width,
    this.height,
    this.verifySize,
    this.titleTextStyle,
    this.helperTextStyle,
    this.resendTextStyle,
    this.registerTextStyle,
    this.padding1,
    this.padding2,
    this.padding3,
    this.padding4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
        borderRadius: containerBorderRadius ??
            const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null && title!.isNotEmpty)
            Padding(
              padding: padding1 ?? const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title!,
                style: titleTextStyle ??
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          if (helperText != null && helperText!.isNotEmpty)
            Padding(
              padding: padding2 ?? const EdgeInsets.only(bottom: 12.0),
              child: Text(
                helperText!,
                style: helperTextStyle ??
                    const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ReactivePinput(
            rxValue: otpValue,
            length: otpLength,
            fieldWidth: fieldWidth,
            fieldHeight: fieldHeight,
            borderRadius: borderRadius,
            defaultColor: defaultColor,
            focusedColor: focusedColor,
            errorColor: errorColor,
            validator: validator,
            onComplete: () {
              if (onComplete != null) {
                onComplete!(otpValue.value);
              }
            },
          ),
          const SizedBox(height: 20),
          if (onResend != null)
            Padding(
              padding: padding3 ?? const EdgeInsets.only(top: 12.0),
              child: TextButton(
                onPressed: onResend,
                child: Text(
                  resendText,
                  style: resendTextStyle ??
                      TextStyle(
                        color: defaultColor ?? GlobalColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          if (showRegisterLink && onRegister != null)
            Padding(
              padding: padding4 ?? const EdgeInsets.only(top: 16.0),
              child: CustomElevatedButton(
                onPressed: onRegister,
                fixedSize: verifySize,
                child: Obx(() {
                  return (isLoading.value)
                      ? const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          registerText ?? "Verify",
                          style: registerTextStyle ??
                              TextStyle(
                                color: defaultColor ?? Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        );
                }),
              ),
            ),
        ],
      ),
    );
  }

  static void showOtpModal({
    required BuildContext context,
    required RxString otpValue,
    required RxBool isLoading,
    double? width,
    double? height,
    int otpLength = 6,
    double fieldWidth = 50.0,
    double fieldHeight = 56.0,
    double borderRadius = 8.0,
    Color? defaultColor,
    Color? focusedColor,
    Color? errorColor,
    VoidCallback? onResend,
    VoidCallback? onRegister,
    String? Function(String?)? validator,
    String resendText = "Resend OTP",
    String? registerText = "Verify",
    bool showRegisterLink = false,
    void Function(String)? onComplete,
    EdgeInsets? padding,
    Color? containerColor,
    BorderRadius? containerBorderRadius,
    String? title,
    String? helperText,
    TextStyle? titleTextStyle,
    TextStyle? helperTextStyle,
    TextStyle? resendTextStyle,
    TextStyle? registerTextStyle,
    EdgeInsets? padding1,
    EdgeInsets? padding2,
    EdgeInsets? padding3,
    EdgeInsets? padding4,
    Size? verifySize,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: containerBorderRadius ??
            const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return OtpWidget(
          isLoading: isLoading,
          width: width,
          title: title,
          helperText: helperText,
          height: height,
          otpValue: otpValue,
          otpLength: otpLength,
          fieldWidth: fieldWidth,
          fieldHeight: fieldHeight,
          borderRadius: borderRadius,
          defaultColor: defaultColor,
          focusedColor: focusedColor,
          errorColor: errorColor,
          onResend: onResend,
          onRegister: onRegister,
          validator: validator,
          resendText: resendText,
          registerText: registerText,
          showRegisterLink: showRegisterLink,
          onComplete: onComplete,
          padding: padding,
          containerColor: containerColor,
          containerBorderRadius: containerBorderRadius,
          titleTextStyle: titleTextStyle,
          helperTextStyle: helperTextStyle,
          resendTextStyle: resendTextStyle,
          registerTextStyle: registerTextStyle,
          padding1: padding1,
          padding2: padding2,
          padding3: padding3,
          padding4: padding4,
          verifySize: verifySize,
        );
      },
    );
  }
}
