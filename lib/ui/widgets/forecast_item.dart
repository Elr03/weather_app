import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/model/weather_info_model.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/widgets/forecast_header.dart';
import 'package:weather_app/ui/widgets/weather_card_element.dart';
import 'package:weather_app/utils/app_copies.dart';
import 'package:weather_app/utils/context_extension.dart';
import 'package:weather_app/utils/weather_utils.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({
    super.key,
    required this.weatherInfo,
    this.onTap,
    this.isCity = false,
  });
  final WeatherInfoModel weatherInfo;
  final VoidCallback? onTap;
  final bool isCity;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
      color: Colors.grey,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: ForecastHeader(
              isCity: isCity,
              weatherInfo: weatherInfo,
              onTap: onTap ??
                  () {
                    weatherProvider.getWeatherInfoByCity(
                        city: weatherInfo.name!,
                        units: weatherProvider.currentTemperatureUnit.unit);
                  },
            ),
          ),
          if (isCity)
            SliverToBoxAdapter(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    weatherProvider.changeTemperatureUnits(weatherInfo);
                  },
                  child: Text(
                      '${AppCopies.changeToLabel} ${getTemperatureSymbolByUnit(weatherInfo.unit ?? '').symbol}'
                      '${AppCopies.aPreposition} ${getTemperatureSymbolByUnit(weatherInfo.unit ?? '').changeUnit.symbol}')),
            ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: context.width * 0.5 - 16,
              mainAxisExtent: 140,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
            itemCount: weatherElementsList.length,
            itemBuilder: (_, index) {
              return WeatherCard(
                weatherElement: weatherElementsList[index],
                weatherInfo: weatherInfo,
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          )
        ],
      ),
    );
  }
}
