import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:weather_check/models/weather_detail_model.dart';
import 'package:weather_check/repository/navigation_handler.dart';
import 'package:weather_check/screens/home_page.dart';
import 'package:weather_check/screens/splashscreen.dart';
import 'package:weather_check/services/locator.dart';

void main() async {

    await dotenv.load(fileName: ".env");
  
  final url = dotenv.env['BASE_URL']!;
  final apiKey = dotenv.env['API_KEY']!;
  await setupLocator(baseApi: url, apiKey: apiKey);
  await _openHive();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((val) {
    runApp(ProviderScope(child: MyApp()));
  });
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
 // Hive.registerAdapter(());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Weather checker',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      navigatorKey: locator<NavigationHandler>().navigatorKey,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomePage.id: (context) =>  HomePage(),
      },
    );
  }
}
