import 'package:dio/dio.dart';
import 'package:weather_app/data/service/request_api.dart';
import 'package:weather_app/utils/endpoints.dart';

class WeatherApi {
  Future<Response> getWeatherInfoByLatAndLong({
    required double lat,
    required double long,
    required String units,
  }) async {
    try {
      final path = '${EndPoints.weatherData}lat=$lat&lon=$long&'
          'appid=16557b273ea4a1fed2e2619b99946157&units=$units&lang=sp';

      final response = await RequestApi.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getWeatherInfoByCity({
    required String city,
    required String units,
  }) async {
    try {
      final path = '${EndPoints.weatherData}appid='
          '16557b273ea4a1fed2e2619b99946157&units=$units&lang=sp&q=$city';
      final response = await RequestApi.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
