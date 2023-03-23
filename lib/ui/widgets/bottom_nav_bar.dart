import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/city_list_screen.dart';
import 'package:weather_app/ui/widgets/add_dialog.dart';
import 'package:weather_app/ui/widgets/bottom_curve_container.dart';
import 'package:weather_app/utils/app_copies.dart';
import 'package:weather_app/utils/context_extension.dart';
import 'package:weather_app/utils/navigation.dart';
import 'package:weather_app/utils/routes.dart';
import 'package:weather_app/utils/weather_utils.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    return SizedBox(
      height: 70,
      width: context.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: Size(context.width, 80),
            painter: BottomCurveContainer(),
          ),
          Center(
            heightFactor: 0.7,
            child: FloatingActionButton(
                backgroundColor: Colors.purple,
                elevation: 10,
                onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const AddDialog(),
                    ),
                child: const Icon(Icons.add)),
          ),
          SizedBox(
            width: context.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () => changeTemperatureUnit(context),
                    child: Text(
                      '${AppCopies.unityLabel}'
                      '${weatherProvider.currentTemperatureUnit.symbol}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: IconButton(
                    icon: Icon(
                      Icons.list_alt,
                      color: Colors.purple,
                    ),
                    onPressed: navigateToCityList,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void navigateToCityList() {
  Navigation.scaleNavigateTo(
      const CityListScreen(), WeatherRoutes.cityListScreen);
}

void changeTemperatureUnit(BuildContext context) async {
  final weatherProvider = context.read<WeatherProvider>();
  if (weatherProvider.currentTemperatureUnit == TemperatureUnits.metric) {
    weatherProvider.setLoadingText(AppCopies.updatingForecasts);
    await weatherProvider.getWeatherInfoByLatAndLong(
        lat: weatherProvider.lat,
        long: weatherProvider.long,
        units: TemperatureUnits.imperial.unit);
    weatherProvider.setCurrentTemperatureUnit(TemperatureUnits.imperial);
  } else {
    await weatherProvider.getWeatherInfoByLatAndLong(
        lat: weatherProvider.lat,
        long: weatherProvider.long,
        units: TemperatureUnits.metric.unit);
    weatherProvider.setCurrentTemperatureUnit(TemperatureUnits.metric);
  }
}
