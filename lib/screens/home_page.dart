import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
            SizedBox(
              height: 8.0,
            ),
            CarouselSlider(
                options: CarouselOptions(
                    height: 120.0,
                    onPageChanged: (index, _) {
                      weatherViewModel.getWeatherInfo(mockData[_.index]["lng"]!, mockData[_.index]["lat"]) ;
                    }),
                items: mockData.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amberAccent),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
                ),
            Text("data"),
          ],
        ),
      ),
    );
  }
}
