import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_copies.dart';
import 'package:weather_app/utils/context_extension.dart';

///This is a error screen to store
///
class WeatherErrorScreen extends StatelessWidget {
  const WeatherErrorScreen({
    super.key,
    required this.errorMessage,
    this.onTap,
    this.buttonLabel = AppCopies.retry,
  });
  final String errorMessage;
  final VoidCallback? onTap;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            //This widget is for a error message
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            //This widget is for error image
            const Icon(
              Icons.error,
              size: 48,
              color: Colors.red,
            ),
            //This widget is for back to store button
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: onTap,
              child: Text(
                buttonLabel.toUpperCase(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
