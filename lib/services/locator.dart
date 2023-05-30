import 'package:get_it/get_it.dart';
import 'package:weather_check/repository/hive_interface.dart';
import 'package:weather_check/repository/hive_repository.dart';
import 'package:weather_check/repository/navigation_handler.dart';
import 'package:weather_check/repository/weather_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({
  String baseApi = "",
  String apiKey = "",
}) async {
// Register dependencies
  locator
      .registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());
  
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImplementation(baseApi, apiKey));
  locator.registerLazySingleton<HiveRepository>(
      () => HiveRepositoryImplementation());
}
