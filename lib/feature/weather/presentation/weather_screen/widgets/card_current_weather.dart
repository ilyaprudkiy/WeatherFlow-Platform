import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/utils/weather_icon_helper.dart';
import '../cubit/weather_screen_cubit.dart';
import '../weather_screen.dart';

class CardCurrentWeatherWidget extends StatelessWidget {
  final String? cityName;

  const CardCurrentWeatherWidget({
    super.key,
    this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherScreenCubit>().state.currentWeather;
    if (weather == null) return const SizedBox.shrink();

    final description = weather.description.isNotEmpty
        ? '${weather.description[0].toUpperCase()}${weather.description.substring(1)}'
        : weather.weatherMain;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildWeatherIcon(
              iconCode: weather.iconCode,
              size: 36,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              cityName ?? weather.cityName,
              style: GoogleFonts.abrilFatface(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TemperatureWidget(temp: weather.temperatureRound),
        Text(
          'Feels like ${weather.feelsTemperatureRound}',
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}
