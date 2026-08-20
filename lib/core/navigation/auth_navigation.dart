import 'package:flutter/material.dart';
import 'package:weather_app/navigation/navigation.dart';

void navigateToWeather(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    MainNavigationRouteNames.weatherScreen,
    (_) => false,
  );
}

void navigateToWelcome(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    MainNavigationRouteNames.welcomeScreen,
    (_) => false,
  );
}
