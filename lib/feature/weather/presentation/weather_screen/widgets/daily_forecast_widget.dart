import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/app_decorations.dart';
import 'package:weather_app/core/widgets/section_header.dart';
import 'package:weather_app/feature/weather/data/models/weather_daily_forecast_model.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/utils/weather_icon_helper.dart';

class DailyForecastWidget extends StatelessWidget {
  const DailyForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final days = context.watch<WeatherScreenCubit>().state.dailyForecast?.days ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '7-Day Forecast'),
        const SizedBox(height: 12),
        if (days.isEmpty)
          const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          )
        else
          Container(
            decoration: AppDecorations.forecastListCard,
            child: Column(
              children: List.generate(
                days.length.clamp(0, 7),
                (index) {
                  final isLast = index == days.length.clamp(0, 7) - 1;
                  return Column(
                    children: [
                      _DailyRow(
                        day: days[index],
                        isToday: index == 0,
                        globalMin: _globalMin(days),
                        globalMax: _globalMax(days),
                      ),
                      if (!isLast)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade300.withValues(alpha: 0.7),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  double _globalMin(List<WeatherDailyItem> days) {
    if (days.isEmpty) return 0;
    return days.map((d) => d.minCelsius).reduce((a, b) => a < b ? a : b);
  }

  double _globalMax(List<WeatherDailyItem> days) {
    if (days.isEmpty) return 30;
    return days.map((d) => d.maxCelsius).reduce((a, b) => a > b ? a : b);
  }
}

class _DailyRow extends StatelessWidget {
  const _DailyRow({
    required this.day,
    required this.isToday,
    required this.globalMin,
    required this.globalMax,
  });

  final WeatherDailyItem day;
  final bool isToday;
  final double globalMin;
  final double globalMax;

  @override
  Widget build(BuildContext context) {
    final dayLabel = isToday ? 'Today' : DateFormat('EEE').format(day.date);
    final dateLabel = DateFormat('MMM d').format(day.date);
    final range = globalMax - globalMin;
    final startFraction =
        range <= 0 ? 0.0 : ((day.minCelsius - globalMin) / range).clamp(0.0, 1.0);
    final endFraction =
        range <= 0 ? 1.0 : ((day.maxCelsius - globalMin) / range).clamp(0.0, 1.0);
    final barWidth = (endFraction - startFraction).clamp(0.08, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  dateLabel,
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
          buildWeatherIcon(iconCode: day.iconCode, size: 28),
          const SizedBox(width: 12),
          SizedBox(
            width: 32,
            child: Text(
              day.minLabel,
              style: const TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EDF2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Positioned(
                      left: constraints.maxWidth * startFraction,
                      width: constraints.maxWidth * barWidth,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.forecastBarStart,
                              AppColors.forecastBarEnd,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 36,
            child: Text(
              day.maxLabel,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
