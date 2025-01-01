import 'package:cc_essentials/helpers/error_handling/error_handling.dart';
import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:get/get.dart' as get_package;
import 'package:dio/dio.dart';

typedef ModelMapper<T> = T Function(Map<String, dynamic> data);

class GenericController<T> extends get_package.GetxController {
  final Future<Response> Function() fetchData;
  final ModelMapper<T> modelMapper;

  GenericController({required this.fetchData, required this.modelMapper});

  final get_package.Rx<T?> data = get_package.Rx<T?>(null);
  final get_package.RxString errorMessage = ''.obs;
  final get_package.RxBool isLoading = false.obs;

  Future<void> fetchItems() async {
    isLoading.value = true;
    try {
      final response = await fetchData();
      logger.i(response.data);
      if (response.statusCode == 200) {
        final rawData = response.data['data'];
        data.value = modelMapper(rawData);
      } else {
        errorMessage.value =
            'Error with error code:${response.statusCode} bearing message : ${response.statusMessage}\n${response.data}';
      }
    } on DioException catch (dioError) {
      handleDioError(dioError);
    } catch (e) {
      logger.e(e.toString());
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
