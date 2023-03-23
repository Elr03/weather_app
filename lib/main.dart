import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/data/service/request_api.dart';
import 'package:weather_app/data/service/weather_api.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/city_list_screen.dart';
import 'package:weather_app/ui/current_weather_screen.dart';
import 'package:weather_app/utils/app_storage.dart';
import 'package:weather_app/utils/navigation.dart';
import 'package:weather_app/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await AppStorage.configurePrefs();
  RequestApi.configureDio();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
            create: (_) => WeatherRepository(WeatherApi())),
        ChangeNotifierProvider(
            create: (context) => WeatherProvider(
                weatherRepository: context.read<WeatherRepository>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const CurrentWeatherScreen(),
        routes: {
          WeatherRoutes.currentWeatherScreen: (_) =>
              const CurrentWeatherScreen(),
          WeatherRoutes.cityListScreen: (_) => const CityListScreen(),
        },
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: Navigation.navigatorKey,
      ),
    );
  }
}
