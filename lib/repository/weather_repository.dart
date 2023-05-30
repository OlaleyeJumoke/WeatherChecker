import 'package:weather_check/services/api_endpoints.dart';
import 'package:weather_check/services/dio_service.dart';
import 'package:weather_check/services/general_response.dart';

abstract class WeatherRepository {
  Future<GeneralResponse> getWeatherInfo(Map<String, dynamic> cityInfo);
 // Future<GeneralResponse> printEOD(String type);
}

class WeatherRepositoryImplementation extends ApiService
    implements WeatherRepository {
      WeatherRepositoryImplementation(String baseApi) : super(baseApi);
  @override
  Future<GeneralResponse> getWeatherInfo(
      Map<String, dynamic> cityInfo) async {
    var response = await get(ApiEndpoints.currentData,
        data: cityInfo, useToken: true);
    return GeneralResponse.fromJson(response);
  }
}
