import 'package:flutter/material.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';

Future<void> showGeoPermissionDialog(
  BuildContext context,
  WeatherScreenCubit weatherCubit,
) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Geodata request'),
      content: const Text(
        'Do you give permission to receive your geodata?',
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                weatherCubit.closeNotificationWindow();
                Navigator.of(dialogContext).pop();
                weatherCubit.getWeatherByGeo();
              },
              child: const Text('Yes'),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: () {
                weatherCubit.closeNotificationWindow();
                Navigator.of(dialogContext).pop();
                weatherCubit.getDefaultCityWeather();
              },
              child: const Text('No'),
            ),
          ],
        ),
      ],
    ),
  );
}
