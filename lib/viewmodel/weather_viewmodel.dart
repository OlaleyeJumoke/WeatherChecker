import 'package:weather_check/models/weather_detail_model.dart';
import 'package:weather_check/utils/constants.dart';
import 'package:weather_check/viewmodel/base_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final WeatherViewModelProvider =
    ChangeNotifierProvider.autoDispose<WeatherViewModel>((ref) {
  return WeatherViewModel(reader: ref.read);
});

class WeatherViewModel extends BaseChangeNotifier {
  Reader reader;

  WeatherViewModel({
    required this.reader,
  });
  WeatherInfoModel? _weatherInfoModel;
  WeatherInfoModel? get weatherInfoModel => _weatherInfoModel;
  getWeatherInfo(String long, lat) async {
    try {
      loading = true;
      var res = await weatherRepository.getWeatherInfo(long, lat);
      loading = false;
      if (res.success) {
        printOnlyInDebug(res.data);
        try {
          _weatherInfoModel = WeatherInfoModel.fromJson(res.data);
        } catch (e) {
          printOnlyInDebug(e);
        }
        printOnlyInDebug(_weatherInfoModel?.weather.first);
      }

      notifyListeners();
    } catch (e) {
      loading = false;
    }
  }
}
