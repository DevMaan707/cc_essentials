import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../services/shared_preferences/shared_preference_service.dart';
import '../logging/logger.dart';
import '../snackbar/snackbar.dart';

void handleDioError(DioException dioError) {
  logger.e(dioError);
  final context = Get.context!;
  if (dioError.response?.statusCode == 401) {
    handleUnauthorized();
  } else if (dioError.type == DioExceptionType.connectionTimeout ||
      dioError.type == DioExceptionType.receiveTimeout) {
    AdvancedBubbleNotification.show(
      context,
      "Connection timed out. Please try again.",
      type: MessageType.info,
    );
  } else if (dioError.type == DioExceptionType.unknown) {
    logger.i(dioError);
    AdvancedBubbleNotification.show(
      context,
      "Unknown Error",
      type: MessageType.error,
    );
  } else {
    AdvancedBubbleNotification.show(
      context,
      "An unexpected error occurred. Please try again.",
      type: MessageType.error,
    );
  }
}

void handleUnauthorized() {
  final context = Get.context!;
  AdvancedBubbleNotification.show(
    context,
    "Session expired. Please log in again.",
    type: MessageType.error,
  );
  SharedPreferencesService().setLoggedIn(false);
}

void handleUnknownError(dynamic e) {
  logger.e(e);
  final context = Get.context!;
  AdvancedBubbleNotification.show(
    context,
    "An unexpected error occurred. Please try again.",
    type: MessageType.error,
  );
}
