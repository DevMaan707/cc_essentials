import 'package:get/get.dart' as get_package;
import 'package:dio/dio.dart';
import 'package:cc_essentials/helpers/error_handling/error_handling.dart';
import 'package:cc_essentials/helpers/logging/logger.dart';

class GenericController<T> extends get_package.GetxController {
  final Future<Response> Function() fetchData;
  final T Function(Map<String, dynamic> json) model;

  GenericController({
    required this.fetchData,
    required this.model,
  });

  final get_package.Rx<T?> data = get_package.Rx<T?>(null);
  final get_package.RxList<T> listData = get_package.RxList<T>();
  final get_package.RxString errorMessage = ''.obs;
  final get_package.RxBool isLoading = false.obs;

  Future<void> fetchItems() async {
    isLoading.value = true;

    try {
      final response = await fetchData();
      logger.i(response.data);
      if (response.statusCode == 200) {
        final rawData = response.data['data'];
        if (rawData is List) {
          final parsedData = rawData
              .map((item) => model(item as Map<String, dynamic>))
              .toList();
          listData.assignAll(parsedData.cast<T>());
          data.value = null;
        } else if (rawData is Map<String, dynamic>) {
          data.value = model(rawData);
          listData.clear();
        } else if (rawData == null) {
          data.value = null;
          listData.clear();
        } else {
          throw Exception("Unexpected data format: ${rawData.runtimeType}");
        }
      } else {
        errorMessage.value =
            'Error: ${response.statusCode}, Message: ${response.statusMessage}\n${response.data}';
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
