import 'package:weather_check/services/api_endpoints.dart';
import 'package:weather_check/services/dio_service.dart';
import 'package:weather_check/services/general_response.dart';

abstract class WeatherRepository {
  Future<GeneralResponse> getWeatherInfo(String long, String lat);
}

class WeatherRepositoryImplementation extends ApiService
    implements WeatherRepository {
  String apiKey;
  WeatherRepositoryImplementation(String baseApi, this.apiKey)
      : super(baseApi);

  @override
  Future<GeneralResponse> getWeatherInfo(String long, String lat) async {
    var response = await get(ApiEndpoints.currentData(long, lat, apiKey),
        useToken: true);
    return GeneralResponse.fromJson(response);
  }
}
