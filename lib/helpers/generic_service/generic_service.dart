import 'package:cc_essentials/api_client/api_client.dart';
import 'package:dio/dio.dart';

class GenericService {
  final ApiClient apiClient;

  GenericService(this.apiClient);

  Future<Response> getData(String endpoint, {Map<String, dynamic>? headers}) {
    return apiClient.get(endpoint, headers: headers);
  }

  Future<Response> postData(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return apiClient.post(endpoint, headers: headers, data: data);
  }
}
// final apiClient = ApiClient('https://api.example.com');
// final genericService = GenericService(apiClient);
//
// void fetchExampleData() async {
//   try {
//     final response = await genericService.getData(
//       '/example-endpoint',
//       headers: {'Authorization': 'Bearer token'},
//     );
//     print(response.data);
//   } catch (e) {
//     print('Error: $e');
//   }
// }
//
// void postExampleData() async {
//   try {
//     final response = await genericService.postData(
//       '/example-endpoint',
//       headers: {'Authorization': 'Bearer token'},
//       data: {'key': 'value'},
//     );
//     print(response.data);
//   } catch (e) {
//     print('Error: $e');
//   }
// }
