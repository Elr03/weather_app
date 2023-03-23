import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/utils/context_extension.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weatherProvider.loadingText,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: context.width, height: 32),
          const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
