import 'package:dio/dio.dart';
import '../../api_client/api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<Response> login(
      {required String phoneNumber, required String endpoint}) {
    return apiClient.post(endpoint, data: {"phone": phoneNumber});
  }

  Future<Response> verify(
      {required String phoneNumber,
      required String code,
      required String endpoint}) {
    return apiClient.post(endpoint, data: {"phone": phoneNumber, "otp": code});
  }

  Future<Response> fetchRegions() {
    const String endpoint = '/v1/regions/all';
    return apiClient.get(endpoint);
  }

  Future<Response> register(
      {required Map<String, dynamic> userData, required String endpoint}) {
    const String endpoint = '/v1/auth/register';
    return apiClient.post(endpoint, data: userData);
  }
}
