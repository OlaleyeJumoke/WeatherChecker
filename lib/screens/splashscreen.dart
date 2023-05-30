import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_check/repository/hive_interface.dart';
import 'package:weather_check/repository/navigation_handler.dart';
import 'package:weather_check/screens/home_page.dart';
import 'package:weather_check/services/locator.dart';
import 'package:weather_check/utils/colors.dart';
import 'package:weather_check/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  var _size = 0.0;
  var _dataReady = Completer();
  var _animationReady = Completer();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation =
        ColorTween(begin: appPrimaryColor, end: kAccent).animate(controller);
    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 2.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    Future.microtask(() => _prepareAppState());
    // _prepareAppState();
    initStateAsync();
  }

  void initStateAsync() async {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _size = 30.0;
      });
      printOnlyInDebug("animation ready");
      _animationReady.complete(true);
    });
  }

  //}

  _prepareAppState() async {
    var _hiveRepository = locator<HiveRepository>();
    await _hiveRepository.openHives([
      kToken,
      kAppDataName,
    ]);
    locator<NavigationHandler>().pushNamed(HomePage.id);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            Hero(
              tag: "main_logo",
              child: Align(
                child: Container(
                  child: Image.asset(
                    "assets/images/foodc.jpeg",
                    height: 100.0,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
