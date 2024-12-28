import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../helpers/errorr_handling/error_handling.dart';
import '../../helpers/logging/logger.dart';
import '../../services/shared_preferences/shared_preference_service.dart';

typedef AuthModelMapper = T Function<T>(Map<String, dynamic> data);

class LoginController extends GetxController {
  final AuthService authService;
  final AuthModelMapper authModelMapper;

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
      logger.i(response.body7);

      if (response.statusCode == 200) {
        final authModel = authModelMapper<AuthModel>(response.data);
        isNewAccount.value = authModel.data.accountExists;
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
      logger.i(response.body);

      if (response.statusCode == 200) {
        final otpModel = authModelMapper<OtpModel>(response.data);
        SharedPreferencesService().setToken(otpModel.data.token);
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
