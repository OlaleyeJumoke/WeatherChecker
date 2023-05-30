import 'package:weather_check/utils/constants.dart';

class ApiEndpoints {
  static String currentData(String long, String lat, String apiKey) =>
      'data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey';
}
