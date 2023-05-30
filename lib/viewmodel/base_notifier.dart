import 'package:flutter/foundation.dart';
import 'package:weather_check/repository/hive_interface.dart';
import 'package:weather_check/repository/navigation_handler.dart';
import 'package:weather_check/repository/weather_repository.dart';
import 'package:weather_check/services/locator.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late WeatherRepository cardPaymentRepository;
  late HiveRepository hiveRepository;

  BaseChangeNotifier({
    NavigationHandler? navigationHandler,
    WeatherRepository? cardPaymentRepository,
    HiveRepository? hiveRepository,
  }) {
    this.cardPaymentRepository = cardPaymentRepository ?? locator();
    this.navigationHandler = navigationHandler ?? locator();
    this.hiveRepository = hiveRepository ?? locator();
  }

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  String _loadingType = "";
  String get loadingType => _loadingType;
  set loadingType(String value) {
    _loadingType = value;
    notifyListeners();
  }

  // TransactionsData? _transactions;
  // TransactionsData get transactions => _transactions!;

  
}
