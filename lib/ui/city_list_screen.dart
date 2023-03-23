import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/widgets/add_dialog.dart';
import 'package:weather_app/ui/widgets/forecasts_page_view.dart';
import 'package:weather_app/utils/app_copies.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final weatherProvider = context.read<WeatherProvider>();
      if (weatherProvider.cityForecastsList.isEmpty) {
        await weatherProvider.recoverLocalCityList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(AppCopies.cityListLabel),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const AddDialog(
                      isCity: true,
                    ),
                  ),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: const ForeCastsPageView(),
    );
  }
}
