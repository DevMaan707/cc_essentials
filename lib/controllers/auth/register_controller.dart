import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../helpers/logging/logger.dart';
import '../../services/auth/auth_service.dart';

typedef ModelMapper<T> = T Function(Map<String, dynamic> data);

class RegisterController extends GetxController {
  final AuthService authService;
  final ModelMapper regionMapper;

  RegisterController({required this.authService, required this.regionMapper});

  final RxBool success = false.obs;
  final RxList<dynamic> regions = <dynamic>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchRegions() async {
    isLoading.value = true;
    try {
      final response = await authService.fetchRegions();
      if (response.statusCode == 200) {
        regions.value = (response.data['data'] as List)
            .map((region) => regionMapper(region))
            .toList();
      } else {
        handleError(response.statusCode, 'Failed to fetch regions.');
      }
    } on DioException catch (dioError) {
      handleDioError(dioError);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> registerUser({
    required Map<String, dynamic> userData,
  }) async {
    isLoading.value = true;
    try {
      final response = await authService.register(userData: userData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        success.value = true;
        return true;
      }
      handleError(response.statusCode, 'Registration failed.');
    } on DioException catch (dioError) {
      handleDioError(dioError);
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  void handleError(int? statusCode, String message) {
    logger.e('Error $statusCode: $message');
    Get.snackbar('Error', message);
  }

  void handleDioError(DioException dioError) {
    final errorMessage =
        dioError.response?.data['message'] ?? 'An error occurred';
    logger.e('DioError: $errorMessage');
    Get.snackbar('Error', errorMessage);
  }
}
// void main() {
//   final authService = AuthService();
//
//   final registerController = RegisterController(
//     authService: authService,
//     regionMapper: (data) => RegionModel.fromJson(data), // Project-specific mapper
//   );
//
//   // Fetch regions
//   registerController.fetchRegions();
//
//   // Register a user
//   registerController.registerUser(userData: {
//     'name': 'John Doe',
//     'email': 'johndoe@example.com',
//     'password': 'securePassword123',
//   });
// }
