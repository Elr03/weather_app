import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/domain/model/weather_info_model.dart';
import 'package:weather_app/utils/app_assets.dart';

class WindCard extends StatelessWidget {
  const WindCard({super.key, required this.weatherInfo});
  final WeatherInfoModel weatherInfo;

  @override
  Widget build(BuildContext context) {
    final radians = (weatherInfo.wind?.deg ?? 0) * pi / 180;
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppAssets.windImage,
            height: 90,
            fit: BoxFit.contain,
          ),
          Transform(
            alignment: Alignment.center, //origin: Offset(100, 100)
            transform: Matrix4.rotationZ(radians),
            child: const Icon(
              Icons.north,
              color: Colors.white,
              size: 36,
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '${weatherInfo.wind?.speed ?? 0} m/s',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
