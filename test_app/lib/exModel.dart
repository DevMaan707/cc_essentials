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

class BookingsResponse {
  final List<BookingData> data;
  final String message;

  BookingsResponse({
    required this.data,
    required this.message,
  });

  factory BookingsResponse.fromJson(Map<String, dynamic> json) {
    return BookingsResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (item) => BookingData.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      message: json['message'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'message': message,
    };
  }
}

class BookingData {
  final User user;
  final Booking booking;

  BookingData({
    required this.user,
    required this.booking,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      booking: Booking.fromJson(json['booking'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'booking': booking.toJson(),
    };
  }
}

class User {
  final String id;
  final String email;
  final String phone;
  final String region;
  final String address;
  final String password;
  final String name;
  final int age;
  final String profileImage;
  final String location;
  final String referralCode;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.region,
    required this.address,
    required this.password,
    required this.name,
    required this.age,
    required this.profileImage,
    required this.location,
    required this.referralCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      region: json['region'] as String,
      address: json['address'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      profileImage: json['profile_image'] as String,
      location: json['location'] as String,
      referralCode: json['referral_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'region': region,
      'address': address,
      'password': password,
      'name': name,
      'age': age,
      'profile_image': profileImage,
      'location': location,
      'referral_code': referralCode,
    };
  }
}

class Booking {
  final String bookingId;
  final String userId;
  final String serviceProviderId;
  final String serviceId;
  final String venueId;
  final String bookingDate;
  final String status;
  final int advancePaid;
  final String planId;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.serviceProviderId,
    required this.serviceId,
    required this.venueId,
    required this.bookingDate,
    required this.status,
    required this.advancePaid,
    required this.planId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'] as String,
      userId: json['user_id'] as String,
      serviceProviderId: json['service_provider_id'] as String,
      serviceId: json['service_id'] as String,
      venueId: json['venue_id'] as String,
      bookingDate: json['booking_date'] as String,
      status: json['status'] as String,
      advancePaid: json['advance_paid'] as int,
      planId: json['plan_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'user_id': userId,
      'service_provider_id': serviceProviderId,
      'service_id': serviceId,
      'venue_id': venueId,
      'booking_date': bookingDate,
      'status': status,
      'advance_paid': advancePaid,
      'plan_id': planId,
    };
  }
}
