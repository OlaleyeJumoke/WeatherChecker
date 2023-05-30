import 'package:flutter/foundation.dart';
import 'package:weather_check/repository/hive_interface.dart';
import 'package:weather_check/repository/navigation_handler.dart';
import 'package:weather_check/repository/weather_repository.dart';
import 'package:weather_check/services/locator.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late WeatherRepository weatherRepository;
  late HiveRepository hiveRepository;

  BaseChangeNotifier({
    NavigationHandler? navigationHandler,
    WeatherRepository? weatherRepository,
    HiveRepository? hiveRepository,
  }) {
    this.weatherRepository = weatherRepository ?? locator();
    this.navigationHandler = navigationHandler ?? locator();
    this.hiveRepository = hiveRepository ?? locator();
  }

  bool _loading = false;

  bool get loading => _loading;

   set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  String _loadingType = "";
  String get loadingType => _loadingType;
  set loadingType(String value) {
    _loadingType = value;
    notifyListeners();
  }
}
