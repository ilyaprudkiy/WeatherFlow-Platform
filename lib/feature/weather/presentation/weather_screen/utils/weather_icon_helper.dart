import 'package:flutter/material.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';

String weatherIconNameFromCode(String code) {
  if (code.isEmpty) return 'cloudy';

  final isNight = code.endsWith('n');
  final prefix = code.length >= 2 ? code.substring(0, 2) : code;

  switch (prefix) {
    case '01':
      return isNight ? 'clear-night' : 'clear-day';
    case '02':
      return isNight ? 'partly-cloudy-night' : 'partly-cloudy-day';
    case '03':
      return 'cloudy';
    case '04':
      return 'overcast';
    case '09':
      return isNight ? 'overcast-night-rain' : 'overcast-day-rain';
    case '10':
      return isNight ? 'partly-cloudy-night-rain' : 'partly-cloudy-day-rain';
    case '11':
      return isNight ? 'thunderstorms-night' : 'thunderstorms-day';
    case '13':
      return 'snow';
    case '50':
      return isNight ? 'fog-night' : 'fog-day';
    default:
      return 'cloudy';
  }
}

Widget buildWeatherIcon({
  required String iconCode,
  double size = 32,
  Color? color,
}) {
  final iconData =
      WeatherIcons.maybeNamed(weatherIconNameFromCode(iconCode)) ??
      WeatherIcons.named('cloudy');

  return WeatherIcon(
    icon: iconData,
    width: size,
    height: size,
    color: color,
  );
}

String uvIndexLabel(double uvi) {
  if (uvi <= 2) return '${uvi.round()} Low';
  if (uvi <= 5) return '${uvi.round()} Moderate';
  if (uvi <= 7) return '${uvi.round()} High';
  if (uvi <= 10) return '${uvi.round()} Very High';
  return '${uvi.round()} Extreme';
}

double toCelsius(double value) {
  if (value > 150) return value - 273.15;
  return value;
}

String formatWindKmh(double speedMs) => '${(speedMs * 3.6).round()} km/h';
