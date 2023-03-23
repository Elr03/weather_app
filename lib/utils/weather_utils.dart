import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/utils/app_copies.dart';

enum TemperatureUnits {
  metric('°C', 'Celsius', 'metric', 'm/s'),
  imperial('°F', 'Fahrenheit', 'imperial', 'mph');

  const TemperatureUnits(
    this.symbol,
    this.name,
    this.unit,
    this.velocity,
  );
  final String symbol;
  final String name;
  final String unit;
  final String velocity;
}

extension WeatherStateExtends on WeatherState {
  String get label {
    switch (this) {
      case WeatherState.unexpectedError:
      case WeatherState.error:
        return AppCopies.unexpectedError;
      case WeatherState.accomplished:
        return AppCopies.successCityAdd;
      case WeatherState.notFound:
        return AppCopies.errorCityInfo;
      default:
        return '';
    }
  }
}

extension ConvertUnitsExtends on TemperatureUnits {
  TemperatureUnits get changeUnit => this == TemperatureUnits.metric
      ? TemperatureUnits.imperial
      : TemperatureUnits.metric;
}

TemperatureUnits getTemperatureSymbolByUnit(String unit) {
  if (unit == TemperatureUnits.metric.unit) {
    return TemperatureUnits.metric;
  }
  return TemperatureUnits.imperial;
}

enum WeatherElements {
  sunrise(Icons.sunny, 'Amanecer', Colors.orangeAccent),
  sunset(Icons.bedtime, 'Atardecer', Colors.indigo),
  feelsLike(Icons.thermostat, 'Sensación', Colors.blueGrey),
  humidity(Icons.water_drop, 'Humedad', Colors.blueGrey),
  visibility(Icons.visibility, 'Visibilidad', Colors.blueGrey),
  pressure(Icons.tire_repair, 'Presión', Colors.blueGrey),
  wind(Icons.air, 'Viento', Colors.blueGrey),
  rain(Icons.thunderstorm, 'Precipitación', Colors.blueGrey);

  const WeatherElements(
    this.icon,
    this.name,
    this.color,
  );
  final IconData icon;
  final String name;
  final Color color;
}

final weatherElementsList = [
  WeatherElements.sunrise,
  WeatherElements.sunset,
  WeatherElements.wind,
  WeatherElements.rain,
  WeatherElements.feelsLike,
  WeatherElements.humidity,
  WeatherElements.visibility,
  WeatherElements.pressure,
];

extension ConvertTemperatureUnits on double {
  double get celsiusToFahrenheit {
    return (this * 9 / 5) + 32;
  }

  double get fahrenheitToCelsius {
    return (this - 32) * 5 / 9;
  }
}
