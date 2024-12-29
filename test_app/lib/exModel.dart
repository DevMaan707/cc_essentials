class LoginResponse {
  final bool success;
  final Data data;
  final String message;

  LoginResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class Data {
  final bool accountExists;
  final bool testPhone;

  Data({
    required this.accountExists,
    required this.testPhone,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accountExists: json['account_exists'] as bool,
      testPhone: json['test_phone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_exists': accountExists,
      'test_phone': testPhone,
    };
  }
}
