import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/loading_screen.dart';
import 'package:weather_app/utils/app_copies.dart';
import 'package:weather_app/utils/context_extension.dart';
import 'package:weather_app/utils/navigation.dart';
import 'package:weather_app/utils/routes.dart';
import 'package:weather_app/utils/weather_utils.dart';

/// Creates a [Dialog] widget that shows the alternatives to contact the benefit supplier.
class AddDialog extends StatefulWidget {
  const AddDialog({
    Key? key,
    this.isCity = false,
  }) : super(key: key);
  final bool isCity;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final weatherCityState = weatherProvider.weatherCityState;
    return Dialog(child: Builder(
      builder: (BuildContext context) {
        switch (weatherCityState) {
          case WeatherState.getting:
            return const SizedBox(
              height: kMinInteractiveDimension * 4,
              child: LoadingScreen(),
            );
          case WeatherState.notFound:
          case WeatherState.unexpectedError:
          case WeatherState.error:
          case WeatherState.accomplished:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        weatherProvider.setWeatherCityState(WeatherState.idle);
                        if (!widget.isCity &&
                            weatherCityState == WeatherState.notFound) {
                          return;
                        }
                        if (!widget.isCity &&
                            weatherCityState == WeatherState.notFound) {
                          return;
                        }
                        if (!widget.isCity) {
                          Navigation.popAndNavigate(
                              WeatherRoutes.cityListScreen);
                        } else {
                          Navigation.popRoute();
                        }
                        cityController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Text(
                  weatherCityState.label,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    weatherProvider.setWeatherCityState(WeatherState.idle);
                    if (!widget.isCity &&
                        weatherCityState == WeatherState.notFound) return;
                    if (!widget.isCity) {
                      Navigation.popAndNavigate(WeatherRoutes.cityListScreen);
                    } else {
                      Navigation.popRoute();
                    }
                    cityController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    AppCopies.okLabel,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          default:
            return SizedBox(
              width: context.width * .85,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          cityController.clear();
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          AppCopies.inputACity,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: context.width,
                          height: kMinInteractiveDimension,
                          child: TextFormField(
                            controller: cityController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                              isDense: false,
                              floatingLabelStyle: TextStyle(
                                color: Colors.purple,
                              ),
                              labelText: AppCopies.cityLabel,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton.icon(
                          onPressed: cityController.text.isEmpty
                              ? null
                              : () async {
                                  weatherProvider.setLoadingText(
                                      AppCopies.searchingCityInfo(
                                          cityController.text.trim()));
                                  await weatherProvider.getWeatherInfoByCity(
                                    city: cityController.text.trim(),
                                    units: weatherProvider
                                        .currentTemperatureUnit.unit,
                                  );
                                  weatherProvider.updateLocalCityList();
                                  cityController.clear();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          icon: const Icon(Icons.search),
                          label: const Text(
                            AppCopies.searchLabel,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
        }
      },
    ));
  }
}
