import 'package:cc_essentials/api_client/api_client.dart';
import 'package:dio/dio.dart';

class GenericService {
  final ApiClient apiClient;

  GenericService(this.apiClient);

  Future<Response> getData(
      {required String endpoint, Map<String, dynamic>? headers}) {
    return apiClient.get(endpoint, headers: headers);
  }

  Future<Response> postData({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return apiClient.post(endpoint, headers: headers, data: data);
  }
}
