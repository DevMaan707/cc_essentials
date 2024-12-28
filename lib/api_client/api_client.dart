import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Response> post(String endpoint,
      {Map<String, dynamic>? headers, Object? data}) async {
    return _dio.post(
      endpoint,
      options: Options(headers: headers),
      data: data,
    );
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    return _dio.get(
      endpoint,
      options: Options(headers: headers),
      queryParameters: queryParams,
    );
  }
}
