import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/feature/weather/data/models/weather_hours_model.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/utils/weather_icon_helper.dart';

const _barBlue = Color(0xFF42A5F5);

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<WeatherScreenCubit>();
    final hours = cubit.state.hourlyForecast?.hours ?? [];
    final selectedIndex = cubit.state.selectedHourIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Hourly Forecast'),
        const SizedBox(height: 12),
        if (hours.isEmpty)
          const SizedBox(
            height: 148,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          )
        else
          SizedBox(
            height: 148,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: hours.length.clamp(0, 12),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final hour = hours[index];
                final isSelected = selectedIndex == index;
                return _HourSlot(
                  label: _hourLabel(hour, index),
                  iconCode: hour.iconCode,
                  temperature: hour.temperatureLabel,
                  isSelected: isSelected,
                  onTap: () => cubit.selectHour(index),
                );
              },
            ),
          ),
      ],
    );
  }

  String _hourLabel(WeatherHourItem hour, int index) {
    if (index == 0) return 'Now';
    final date = DateTime.fromMillisecondsSinceEpoch(hour.dataTime * 1000);
    return DateFormat('ha').format(date);
  }
}

class _HourSlot extends StatelessWidget {
  const _HourSlot({
    required this.label,
    required this.iconCode,
    required this.temperature,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String iconCode;
  final String temperature;
  final bool isSelected;
  final VoidCallback onTap;

  static const _cardWidth = 72.0;
  static const _cardHeight = 136.0;
  static const _cardRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.black87 : Colors.white;
    final tempColor = isSelected ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _cardWidth,
        height: _cardHeight,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : _barBlue,
          borderRadius: BorderRadius.circular(_cardRadius),
          border: Border.all(
            color: isSelected
                ? Colors.grey.shade300
                : _barBlue.withValues(alpha: 0.4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            if (isSelected)
              buildWeatherIcon(iconCode: iconCode, size: 32)
            else
              ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                child: buildWeatherIcon(iconCode: iconCode, size: 32),
              ),
            const SizedBox(height: 10),
            Text(
              temperature,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: tempColor,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 28 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'See all',
            style: TextStyle(color: Colors.blueAccent, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
