import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_check/repository/hive_interface.dart';
import 'package:weather_check/services/api_error_response.dart';
import 'package:weather_check/services/api_response.dart';
import 'package:weather_check/services/locator.dart';
import 'package:weather_check/utils/constants.dart';

import 'connection_service.dart';

abstract class ApiService {
  //final _storageService = locator<SecureStorageService>();
  late Dio dio;
  //late String getBaseUrl;
//Production
  ApiService(String baseApi) {
    final options = BaseOptions(
      baseUrl: "https://$baseApi",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    );
   // getBaseUrl = baseApi;
    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (
        options,
        handler,
      ) async {
        //no internet? reject request
        if (!await ConnectionStatus.isConnected()) {
          handler.reject(
            DioError(
              requestOptions: options,
              error:
                  "Oops! Looks like you're not connected to the internet. Check your internet connection and try again.",
            ),
          );
        }

        handler.next(options);
      }, onResponse: (response, handler) async {
        if (response.statusCode == 403) {
          handler.resolve(
            Response(
                requestOptions: response.requestOptions,
                statusCode: 403,
                data: {
                  'message': "Session timed out. Try again",
                }),
          );
        } else {
          handler.next(response);
        }
      }, onError: (error, handler) async {
        if (error.response?.statusCode == 403) {
          handler.resolve(
            Response(
                requestOptions: error.requestOptions,
                statusCode: 403,
                data: {
                  'message': "Session timed out. Try again",
                }),
          );
        } else {
          handler.next(error);
        }
      }),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  Future<Map<String, dynamic>> _getDioHeader([bool useToken = false]) async {
    var token;
    if (useToken) {
      token = await locator<HiveRepository>().get(key: kToken, name: kToken);
    }
    printOnlyInDebug('token:$token');
    return {
      'Content-type': 'application/json',
      'b-access-token': useToken ? token : null
    };
  }

  Future<Either<Failure, Success>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;

      var data = req.data;

      // log.e(data);

      if ("${req.statusCode}".startsWith('2')) {
        //CHECK THAT STATUS IS NOT FALSE
        if ((data["status"].toString()) != "false") {
          return Right(Success(data));
        } else if ((data["status"].toString()) == "false") {
          return Left(
            Failure(
              ApiErrorResponse(
                message: data["message"],
                // type: ParserUtil.parseApiErrorCode(data),
                data: data,
              ),
            ),
          );
        } else {
          return Right(Success(data));
        }
      } else {
        // if ("${req.statusCode}".startsWith('5')) {
        //   return Left(
        //     Failure(
        //       const ApiErrorResponse(
        //         message: "Oops. An error occured, please try again.",
        //         errorCode: 500,
        //       ),
        //     ),
        //   );
        // }
      }

      return Left(Failure.fromMap(data));
    } on DioError catch (e) {
      if ("${e.response?.statusCode}".startsWith('5')) {
        ///TODO show error dialog
        return Left(
          Failure(
            const ApiErrorResponse(
              message: "An error occured, please try again.",
              errorCode: 500,
            ),
          ),
        );
      }

      if (e.type == DioErrorType.connectionTimeout) {
        return Left(
          Failure(
            const ApiErrorResponse(
              errorCode: 599,
              message:
                  "Connection timeout. Check your internet connection and please try again.",
            ),
          ),
        );
      }

      if (e.type == DioErrorType.unknown) {
        return Left(
          Failure(
            const ApiErrorResponse(
              shouldDisplayError: false,
              errorCode: 402,
              message:
                  "Network error. Check your internet connection and try again.",
            ),
          ),
        );
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          return Left(
            Failure(
              const ApiErrorResponse(
                message: "Resource not found.",
                errorCode: 404,
              ),
            ),
          );
        }
        if (e.response?.statusCode == 401) {
          return Left(
            Failure(
              const ApiErrorResponse(
                message: "Resource not found.",
                errorCode: 401,
              ),
            ),
          );
        }

        if (e.response?.data != null && e.response!.data is Map) {
          return Left(Failure.fromMap(e.response!.data,
              errorCode: e.response!.statusCode));
        }

        return Left(
          Failure(
            ApiErrorResponse(message: e.message, errorCode: 05),
          ),
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Left(Failure(
          ApiErrorResponse(message: e.message, errorCode: 05),
        ));
      }
    }
  }

  Future<Either<Failure, Success>> delete(
    String uri, {
    bool useToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return makeRequest(
        dio.delete(
          "/$uri",
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: await _getDioHeader(useToken)),
          cancelToken: cancelToken,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, Success>> get(
    String uri, {
    bool useToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      printOnlyInDebug('uri: $uri');
      return makeRequest(
        dio.request(
          "/$uri",
          data: data,
          options:
              Options(method: "GET", headers: await _getDioHeader(useToken)),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, Success>> patch(
    String uri, {
    bool useToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return makeRequest(
        dio.patch(
          "/$uri",
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: await _getDioHeader(useToken)),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, Success>> post(
    String uri, {
    bool useToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return makeRequest(
        dio.post(
          "/$uri",
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: await _getDioHeader(useToken)),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );
    } catch (e) {
      //log.e(e);
      rethrow;
    }
  }

  Future<Either<Failure, Success>> put(
    String uri, {
    bool useToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return makeRequest(
        dio.put(
          "/$uri",
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: await _getDioHeader(useToken)),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
