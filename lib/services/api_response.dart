import 'package:weather_check/services/api_error_response.dart';
import 'package:weather_check/utils/constants.dart';

abstract class ApiResponse {}

class Success extends ApiResponse {
  final Map<String, dynamic> data;

  Success(this.data);

  @override
  List<Object?> get props => [data];
}

class Failure extends ApiResponse {
  final ApiErrorResponse error;

  Failure(this.error);

  factory Failure.fromMap(Map<String, dynamic> json, {int? errorCode = 402}) {
    return Failure(
      ApiErrorResponse(
          errorCode: errorCode,
          message: getErrorMessage(json["message"]),
          data: json["data"]),
    );
  }

  static String getErrorMessage(Object? message) {
    if (message is List<String> && message.isNotEmpty) {
      return message.first;
    }
    if (message is String) return message;
    return "Something went wrong, try again !!!";
  }

  @override
  List<Object?> get props => [error];
}
