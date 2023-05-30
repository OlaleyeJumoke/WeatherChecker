import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_check/utils/constants.dart';
import 'package:weather_check/viewmodel/weather_viewmodel.dart';

import '../utils/mockdata.dart';

class HomePage extends StatefulHookConsumerWidget {
  static String id = 'home_screen';
  const HomePage({super.key});

  @override
  _HomePageStateState createState() => _HomePageStateState();
}

class _HomePageStateState extends ConsumerState<HomePage> {
  late WeatherViewModel weatherViewModel;

  @override
  void initState() {
    var initData = mockData[0];
    Future.microtask(() =>
        weatherViewModel.getWeatherInfo(initData["lng"]!, initData["lat"]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weatherViewModel = ref.watch(WeatherViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          "Weather checker",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  height: 120.0,
                  onPageChanged: (index, _) {
                    weatherViewModel.getWeatherInfo(
                        mockData[index]["lng"]!, mockData[index]["lat"]);
                  }),
              items: mockData.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.7)),
                        child: Text(
                          '${i["city"]}, ${i["admin_name"]}, ${i["country"]}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ));
                  },
                );
              }).toList(),
            ),
            const SizedBox(
              height: 8.0,
            ),
            weatherViewModel.loading
                ? Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: const CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Column(
                      children: [
                        ItemWidget(
                          text:
                              "Longitude, Latitude: ${weatherViewModel.weatherInfoModel?.coord.lon}, ${weatherViewModel.weatherInfoModel?.coord.lat}",
                        ),
                        ItemWidget(
                          text:
                              "Weather description: ${weatherViewModel.weatherInfoModel?.weather.first.main}; ${weatherViewModel.weatherInfoModel?.weather.first.description}",
                        ),
                        ItemWidget(
                          text:
                              "Minimum temp: ${weatherViewModel.weatherInfoModel?.main.tempMin}K",
                        ),
                        ItemWidget(
                          text:
                              "Maximum temp: ${weatherViewModel.weatherInfoModel?.main.tempMax}K",
                        ),
                        ItemWidget(
                          text:
                              "Location : ${weatherViewModel.weatherInfoModel?.name}, ${weatherViewModel.weatherInfoModel?.sys.country}",
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.03),
            borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        width: MediaQuery.of(context).size.width,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.pinkAccent.withOpacity(0.7),
              fontWeight: FontWeight.w500),
        ));
  }
}
