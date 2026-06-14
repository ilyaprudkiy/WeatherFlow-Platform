import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_decorations.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/utils/weather_icon_helper.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';

class WeatherMetricsCardWidget extends StatelessWidget {
  const WeatherMetricsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WeatherScreenCubit>().state;
    final weather = state.currentWeather;
    if (weather == null) return const SizedBox.shrink();

    final uv = state.todayUvIndex ?? 0;

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: AppDecorations.weatherMetricsCard,
      child: Row(
        children: [
          Expanded(
            child: _MetricColumn(
              icon: const Icon(Icons.water_drop_outlined, color: Colors.white),
              label: 'Humidity',
              value: '${weather.humidity}%',
            ),
          ),
          _divider(),
          Expanded(
            child: _MetricColumn(
              icon: WeatherIcon(
                icon: WeatherIcons.named('wind'),
                width: 22,
                height: 22,
                color: Colors.white,
              ),
              label: 'Wind',
              value: formatWindKmh(weather.windSpeed),
            ),
          ),
          _divider(),
          Expanded(
            child: _MetricColumn(
              icon: const Icon(Icons.wb_sunny_outlined, color: Colors.white),
              label: 'UV Index',
              value: uvIndexLabel(uv),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.black26,
    );
  }
}

class _MetricColumn extends StatelessWidget {
  const _MetricColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  final Widget icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
