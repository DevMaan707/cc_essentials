import 'package:get/get.dart';

import '../../services/auth/auth_service.dart';

typedef RegionMapper = T Function<T>(Map<String, dynamic> data);

class RegisterController extends GetxController {
  final AuthService authService;
  final RegionMapper regionMapper;

  RegisterController({required this.authService, required this.regionMapper});

  RxBool success = false.obs;
  RxList<dynamic> regions = <dynamic>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchRegions() async {
    isLoading.value = true;
    try {
      final response = await authService.fetchRegions();
      if (response.statusCode == 200) {
        regions.value = (response.data['data'] as List)
            .map((region) => regionMapper<Region>(region))
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
    required Map<String, dynamic> userData, // Accept raw data for flexibility
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
}
