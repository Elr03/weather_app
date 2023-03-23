import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/widgets/add_dialog.dart';
import 'package:weather_app/ui/widgets/dot_indicator.dart';
import 'package:weather_app/ui/widgets/forecast_item.dart';
import 'package:weather_app/utils/app_copies.dart';

class ForeCastsPageView extends StatefulWidget {
  const ForeCastsPageView({super.key});

  @override
  State<ForeCastsPageView> createState() => _ForeCastsPageViewState();
}

class _ForeCastsPageViewState extends State<ForeCastsPageView> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final cityForecastsList = weatherProvider.cityForecastsList;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: cityForecastsList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppCopies.cityListEmpty),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => const AddDialog(
                              isCity: true,
                            ),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text(AppCopies.addCity),
                        )
                      ],
                    )
                  : PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      itemCount: cityForecastsList.length,
                      itemBuilder: (_, int index) {
                        final weatherInfo = cityForecastsList[index];
                        return ForecastItem(
                          weatherInfo: weatherInfo,
                          isCity: true,
                        );
                      },
                      onPageChanged: onPageChanged,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                cityForecastsList.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DotIndicator(
                    index: index,
                    pageIndex: _pageIndex,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void onPageChanged(index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
