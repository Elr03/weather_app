import 'package:flutter/material.dart';
import 'package:weather_app/domain/model/weather_info_model.dart';
import 'package:weather_app/ui/widgets/text_card.dart';
import 'package:weather_app/ui/widgets/wind_card.dart';
import 'package:weather_app/utils/app_copies.dart';
import 'package:weather_app/utils/date_utils.dart';
import 'package:weather_app/utils/weather_utils.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard(
      {super.key, required this.weatherElement, required this.weatherInfo});
  final WeatherElements weatherElement;
  final WeatherInfoModel weatherInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: weatherElement.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  weatherElement.icon,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  weatherElement.name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            if (weatherElement == WeatherElements.sunrise)
              Expanded(
                child: TextCard(
                  title: unixToDate(weatherInfo.sys?.sunrise ?? 0)[0],
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  subTitle: unixToDate(weatherInfo.sys?.sunrise ?? 0)[1],
                  subTitleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            if (weatherElement == WeatherElements.sunset)
              Expanded(
                child: TextCard(
                  title: unixToDate(weatherInfo.sys?.sunset ?? 0)[0],
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  subTitle: unixToDate(weatherInfo.sys?.sunset ?? 0)[1],
                  subTitleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            if (weatherElement == WeatherElements.feelsLike)
              Expanded(
                child: TextCard(
                  title:
                      '${(weatherInfo.main?.feelsLike ?? 0).toStringAsFixed(0)}°',
                  titleStyle: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            if (weatherElement == WeatherElements.humidity)
              Expanded(
                child: TextCard(
                  title:
                      '${(weatherInfo.main?.humidity ?? 0).toStringAsFixed(0)}%',
                  titleStyle: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            if (weatherElement == WeatherElements.visibility)
              Expanded(
                child: TextCard(
                  title:
                      '${((weatherInfo.visibility ?? 0) / 1000).toStringAsFixed(0)} km',
                  titleStyle: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            if (weatherElement == WeatherElements.pressure)
              Expanded(
                child: TextCard(
                  title: '${(weatherInfo.main?.pressure ?? 0)} hPa',
                  titleStyle: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            if (weatherElement == WeatherElements.wind)
              WindCard(weatherInfo: weatherInfo),
            if (weatherElement == WeatherElements.rain)
              Expanded(
                child: TextCard(
                  title: '${weatherInfo.rain?.the1H ?? 0} mm',
                  titleStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subTitle: AppCopies.inLastHour,
                  subTitleStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
