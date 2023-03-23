import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/loading_screen.dart';
import 'package:weather_app/ui/weather_error_screen.dart';
import 'package:weather_app/ui/widgets/bottom_nav_bar.dart';
import 'package:weather_app/ui/widgets/forecast_item.dart';
import 'package:weather_app/utils/app_copies.dart';
import 'package:weather_app/utils/geolocation.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  late Future<void> getWeatherInfoFuture;
  late WeatherProvider weatherProvider;

  @override
  void initState() {
    super.initState();
    getWeatherInfoFuture = getWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
          future: getWeatherInfoFuture,
          builder: (_, __) {
            switch (weatherProvider.weatherState) {
              case WeatherState.empty:
                return WeatherErrorScreen(
                    errorMessage:
                        'No se encontró información para esta ubicación.',
                    onTap: refreshWeatherInfo);
              case WeatherState.getting:
              case WeatherState.idle:
                return const LoadingScreen();
              case WeatherState.accomplished:
                return SafeArea(
                  child: Stack(
                    children: [
                      ForecastItem(
                        weatherInfo:
                            weatherProvider.currentLocationWeatherInfo!,
                        onTap: refreshWeatherInfo,
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomNavBar(),
                      )
                    ],
                  ),
                );
              case WeatherState.unexpectedError:
              case WeatherState.error:
                return WeatherErrorScreen(
                    errorMessage: AppCopies.unexpectedError,
                    onTap: refreshWeatherInfo);
              case WeatherState.notFound:
                return WeatherErrorScreen(
                    errorMessage: AppCopies.notFoundLocation,
                    onTap: refreshWeatherInfo);

              default:
                return const SizedBox();
            }
          }),
    );
  }

  //This future, retrieve a weather info
  Future<void> getWeatherInfo() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      weatherProvider.setWeatherState(WeatherState.idle);
      weatherProvider.setLoadingText(AppCopies.gettingLocationPermissions);
      final permission = await getPermission();
      if (permission == 'Permissions granted') {
        weatherProvider.setLoadingText(AppCopies.gettingLocation);
        final signedGeoLocalization = await getLocation();
        weatherProvider.setLat(signedGeoLocalization.latitude);
        weatherProvider.setLong(signedGeoLocalization.longitude);
        final currentTemperatureUnit = weatherProvider.currentTemperatureUnit;
        weatherProvider.setLoadingText(AppCopies.gettingWeatherInfo);
        await weatherProvider.getWeatherInfoByLatAndLong(
          lat: weatherProvider.lat,
          long: weatherProvider.long,
          units: currentTemperatureUnit.unit,
        );
      }
    });
  }

  //This function resets the future of getLevelsByMembership, and reruns it
  void refreshWeatherInfo() => setState(() {
        getWeatherInfoFuture = getWeatherInfo();
      });
}
