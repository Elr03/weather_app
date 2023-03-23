import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/model/weather_info_model.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/utils/app_copies.dart';

class ForecastHeader extends SliverPersistentHeaderDelegate {
  ForecastHeader({
    required this.weatherInfo,
    this.onTap,
    this.isCity = false,
  });
  final WeatherInfoModel weatherInfo;
  final VoidCallback? onTap;
  final bool isCity;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    final weatherProvider = context.read<WeatherProvider>();
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      weatherInfo.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isCity)
                    GestureDetector(
                      onTap: onTap,
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.greenAccent,
                      ),
                    ),
                  if (isCity)
                    GestureDetector(
                      onTap: () {
                        weatherProvider.removeForecast(weatherInfo);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    )
                ],
              ),
              if (progress > 0.09)
                Text(
                  '${(weatherInfo.main?.temp ?? 0).toStringAsFixed(0)}° | '
                  '${weatherInfo.weather?.first.description ?? '-'}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(weatherInfo.main?.temp ?? 0).toStringAsFixed(0)}°',
                          style: const TextStyle(
                            fontSize: 52,
                            color: Colors.white,
                          ),
                        ),
                        Image.network(
                          AppCopies.imageUrl(
                              weatherInfo.weather?.first.icon ?? '01d'),
                          height: 52,
                        )
                      ],
                    ),
                    Text(
                      (weatherInfo.weather?.first.description ?? '-')
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppCopies.minLabel} ${weatherInfo.main?.tempMin}°',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${AppCopies.maxLabel} ${weatherInfo.main?.tempMax}°',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 154;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
