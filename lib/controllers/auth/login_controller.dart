import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../helpers/errorr_handling/api_response_wrapper.dart';
import '../../helpers/errorr_handling/error_handling.dart';
import '../../helpers/logging/logger.dart';
import '../../services/auth/auth_service.dart';
import '../../services/shared_preferences/shared_preference_service.dart';

typedef ModelMapper<T> = T Function(Map<String, dynamic> data);

class LoginController extends GetxController {
  final AuthService authService;
  final ModelMapper authModelMapper; // Generic model mapper

  LoginController({required this.authService, required this.authModelMapper});

  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isNewAccount = false.obs;
  final RxString phoneNumber = ''.obs;

  bool validatePhoneNumber(String phoneNumber) {
    final RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');
    if (!phoneRegExp.hasMatch(phoneNumber)) {
      errorMessage.value = 'Phone number is invalid.';
      return false;
    }
    return true;
  }

  Future<bool> login(String phoneNumber) async {
    isLoading.value = true;
    try {
      this.phoneNumber.value = '+91$phoneNumber';
      final response = await authService.login(this.phoneNumber.value);
      logger.i(response.data);

      if (response.statusCode == 200) {
        final authResponse = ApiResponseWrapper.fromJson(
          response.data,
          authModelMapper,
        );
        isNewAccount.value = authResponse.data['accountExists'] ?? false;
        return true;
      }
    } on DioException catch (dioError) {
      handleDioError(dioError);
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  Future<bool> verifyOtp(String code) async {
    isLoading.value = true;
    try {
      final response = await authService.verify(
        phoneNumber: phoneNumber.value,
        code: code,
      );
      logger.i(response.data);

      if (response.statusCode == 200) {
        final otpResponse = ApiResponseWrapper.fromJson(
          response.data,
          authModelMapper,
        );
        SharedPreferencesService().setToken(otpResponse.data['token']);
        SharedPreferencesService().setLoggedIn(true);
        return true;
      }
    } on DioException catch (dioError) {
      handleDioError(dioError);
    } finally {
      isLoading.value = false;
    }
    return false;
  }
}
