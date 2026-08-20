import 'package:flutter/material.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';

Future<void> showGeoPermissionDialog(
  BuildContext context,
  WeatherScreenCubit weatherCubit,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
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
                Navigator.of(dialogContext, rootNavigator: true).pop();
                weatherCubit.closeNotificationWindow();
                weatherCubit.getWeatherByGeo();
              },
              child: const Text('Yes'),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext, rootNavigator: true).pop();
                weatherCubit.closeNotificationWindow();
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
