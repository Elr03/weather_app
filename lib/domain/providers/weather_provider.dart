import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/model/weather_info_model.dart';
import 'package:weather_app/utils/app_storage.dart';
import 'package:weather_app/utils/weather_utils.dart';

class WeatherProvider with ChangeNotifier {
  WeatherProvider({required this.weatherRepository});
  final WeatherRepository weatherRepository;

  String _loadingText = '';
  String get loadingText => _loadingText;
  void setLoadingText(String text) {
    _loadingText = text;
    notifyListeners();
  }

  double _lat = 0.0;
  double get lat => _lat;
  void setLat(double lat) {
    _lat = lat;
    notifyListeners();
  }

  double _long = 0.0;
  double get long => _long;
  void setLong(double long) {
    _long = long;
    notifyListeners();
  }

  TemperatureUnits _currentTemperatureUnit = TemperatureUnits.metric;
  TemperatureUnits get currentTemperatureUnit => _currentTemperatureUnit;
  void setCurrentTemperatureUnit(TemperatureUnits unit) {
    _currentTemperatureUnit = unit;
    notifyListeners();
  }

  ///Stores the [WeatherState] and is used by all the
  ///methods that call an api inside [WeatherState]
  WeatherState _weatherState = WeatherState.idle;
  WeatherState get weatherState => _weatherState;
  void setWeatherState(WeatherState state) {
    _weatherState = state;
    notifyListeners();
  }

  WeatherState _weatherCityState = WeatherState.idle;
  WeatherState get weatherCityState => _weatherCityState;
  void setWeatherCityState(WeatherState state) {
    _weatherCityState = state;
    notifyListeners();
  }

  WeatherInfoModel? _currentLocationWeatherInfo;
  WeatherInfoModel? get currentLocationWeatherInfo =>
      _currentLocationWeatherInfo;
  void setCurrentLocationWeatherInfo(WeatherInfoModel? weatherInfo) {
    _currentLocationWeatherInfo = weatherInfo;
    notifyListeners();
  }

  List<WeatherInfoModel> _cityForecastsList = [];
  List<WeatherInfoModel> get cityForecastsList => _cityForecastsList;
  void setCityForecastsList(List<WeatherInfoModel> list) {
    _cityForecastsList = list;
    notifyListeners();
  }

  void addForecast(WeatherInfoModel weatherInfo) {
    _cityForecastsList.add(weatherInfo);
    notifyListeners();
  }

  void removeForecast(WeatherInfoModel weatherInfo) {
    final index = _cityForecastsList.indexOf(weatherInfo);
    _cityForecastsList.removeAt(index);
    notifyListeners();
  }

  void changeTemperatureUnits(WeatherInfoModel infoModel) {
    final index =
        _cityForecastsList.indexWhere((element) => element == infoModel);

    if (index > -1) {
      final unit = _cityForecastsList[index].unit;
      if (unit == TemperatureUnits.metric.unit) {
        _cityForecastsList[index].main?.temp =
            (_cityForecastsList[index].main?.temp ?? 0).celsiusToFahrenheit;
        _cityForecastsList[index].unit = TemperatureUnits.imperial.unit;
      } else {
        _cityForecastsList[index].main?.temp =
            (_cityForecastsList[index].main?.temp ?? 0).fahrenheitToCelsius;
        _cityForecastsList[index].unit = TemperatureUnits.metric.unit;
      }
      notifyListeners();
    }
  }

  void updateLocalCityList() {
    if (_cityForecastsList.isEmpty) return;
    List<String> cityList =
        _cityForecastsList.map((e) => jsonEncode(e.toJson())).toList();
    AppStorage.saveCityList(cityList);
    notifyListeners();
  }

  Future<void> recoverLocalCityList() async {
    final stringList = await AppStorage.recoverCityList();
    List<WeatherInfoModel> cityList = stringList
        .map((e) => WeatherInfoModel.fromJson(jsonDecode(e)))
        .toList();
    if (cityList.isNotEmpty) {
      setCityForecastsList(cityList);
    }
  }

  Future<void> getWeatherInfoByLatAndLong({
    required double lat,
    required double long,
    required String units,
  }) async {
    try {
      setWeatherState(WeatherState.getting);
      final data = await weatherRepository.getWeatherInfoByLatAndLong(
        lat: lat,
        long: long,
        units: units,
      );

      if (data is WeatherState) {
        setWeatherState(data);
        setCurrentLocationWeatherInfo(null);
      } else {
        setCurrentLocationWeatherInfo(WeatherInfoModel.fromJson(data));
        if (_currentLocationWeatherInfo != null) {
          setWeatherState(WeatherState.accomplished);
        } else {
          setWeatherState(WeatherState.empty);
        }
      }
    } catch (e) {
      setWeatherState(WeatherState.appError);
    }
  }

  Future<void> getWeatherInfoByCity({
    required String city,
    required String units,
  }) async {
    try {
      setWeatherCityState(WeatherState.getting);
      final data = await weatherRepository.getWeatherInfoByCity(
        city: city,
        units: units,
      );
      if (data is WeatherState) {
        setWeatherCityState(data);
      } else {
        final cityWeatherInfo = WeatherInfoModel.fromJson(data);
        addForecast(cityWeatherInfo);
        setWeatherCityState(WeatherState.accomplished);
      }
    } catch (e) {
      setWeatherState(WeatherState.appError);
    }
  }
}
