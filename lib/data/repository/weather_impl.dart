import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/data/service/request_api.dart';
import 'package:weather_app/utils/weather_api_exceptions.dart';

extension WeatherImpl on WeatherRepository {
  Future<dynamic> getWeatherInfoByLatAndLongImpl({
    required double lat,
    required double long,
    required String units,
  }) async {
    try {
      final response = await weatherApi.getWeatherInfoByLatAndLong(
        lat: lat,
        long: long,
        units: units,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (RequestApi.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return WeatherState.error;
        }
        return response.data;
      }
      return WeatherState.error;
    } on DioError catch (dioError) {
      final weatherApiExceptions = WeatherApiExceptions.fromDioError(dioError);
      final weatherState = weatherApiExceptions.exceptionState;
      if (weatherState != WeatherState.idle) {
        debugPrint(weatherApiExceptions.toString());
        return weatherState;
      }
      throw weatherApiExceptions;
    }
  }

  Future<dynamic> getWeatherInfoByCityImpl({
    required String city,
    required String units,
  }) async {
    try {
      final response = await weatherApi.getWeatherInfoByCity(
        city: city,
        units: units,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (RequestApi.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return WeatherState.error;
        }
        final weatherInfo = response.data;
        weatherInfo['unit'] = units;
        return weatherInfo;
      }
      return WeatherState.error;
    } on DioError catch (dioError) {
      final weatherApiExceptions = WeatherApiExceptions.fromDioError(dioError);
      final weatherState = weatherApiExceptions.exceptionState;
      if (weatherState != WeatherState.idle) {
        debugPrint(weatherApiExceptions.toString());
        return weatherState;
      }
      throw weatherApiExceptions;
    }
  }
}
