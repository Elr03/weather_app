import 'package:weather_app/data/repository/weather_impl.dart';
import 'package:weather_app/data/service/weather_api.dart';

enum WeatherState {
  idle,
  getting,
  accomplished,
  empty,
  notFound,
  conflict,
  error,
  unexpectedError,
  appError,
}

class WeatherRepository {
  WeatherRepository(this.weatherApi);
  final WeatherApi weatherApi;

  Future<dynamic> getWeatherInfoByLatAndLong({
    required double lat,
    required double long,
    required String units,
  }) async {
    return await getWeatherInfoByLatAndLongImpl(
      lat: lat,
      long: long,
      units: units,
    );
  }

  Future<dynamic> getWeatherInfoByCity({
    required String city,
    required String units,
  }) async {
    return await getWeatherInfoByCityImpl(
      city: city,
      units: units,
    );
  }
}
