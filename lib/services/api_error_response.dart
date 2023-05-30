

class ApiErrorResponse {
  final ApiErrorType type;
  final String? message;
  final Map<String, dynamic>? data;
  final int? errorCode;
  final bool? shouldDisplayError;

  const ApiErrorResponse({
    this.type = ApiErrorType.unknown,
    this.message,
    this.data,
    this.errorCode,
    this.shouldDisplayError,
  });

 
}

enum ApiErrorType {
  KYC_REQUIRED,
  INSUFFICENT_BAL,
  BANK_ACCOUNT_NOT_FOUND,
  unknown,
}