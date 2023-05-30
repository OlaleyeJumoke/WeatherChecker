import 'package:dartz/dartz.dart';
import 'api_error_response.dart';
import 'api_response.dart';

class GeneralResponse<T> {
  final bool success;
  final String message;
  final ApiErrorResponse? error;
  final T? data;

  GeneralResponse({
    this.success: false,
    this.message: '',
    this.error,
    this.data,
  });

  factory GeneralResponse.fromJson(
    Either<Failure, Success> json, {
    T Function(Map<String, dynamic> json)? parseJson,
    String Function(Map<String, dynamic> json)? parseMessage,
  }) {
    return json.fold(
      (failure) => GeneralResponse(
        error: failure.error,
        message: "",
      ),
      (success) => GeneralResponse(
        success: true,
        message: parseMessage != null
            ? parseMessage(success.data)
            : success.data['message'].toString(),
        data: parseJson != null
            ? parseJson(success.data)
            : success.data['data'] ?? success.data,
      ),
    );
  }
}
