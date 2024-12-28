class ApiResponseWrapper<T> {
  final T data;
  final String? message;
  final bool success;

  ApiResponseWrapper({
    required this.data,
    this.message,
    required this.success,
  });

  factory ApiResponseWrapper.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponseWrapper<T>(
      data: fromJsonT(json['data']),
      message: json['message'],
      success: json['success'] ?? true,
    );
  }
}
