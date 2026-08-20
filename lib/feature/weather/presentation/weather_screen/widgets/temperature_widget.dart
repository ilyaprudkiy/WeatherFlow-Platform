import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class TemperatureWidget extends StatelessWidget {
  final String? temp;

  const TemperatureWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Text(temp ?? '', style: AppTextStyles.weatherTemperature);
  }
}
