class ApiResponseWrapper<T> {
  final bool success;
  final T data;
  final String? message;

  ApiResponseWrapper({
    required this.success,
    required this.data,
    this.message,
  });

  factory ApiResponseWrapper.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) modelMapper,
  ) {
    return ApiResponseWrapper<T>(
      success: json['success'] as bool,
      data: modelMapper(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );
  }
}
