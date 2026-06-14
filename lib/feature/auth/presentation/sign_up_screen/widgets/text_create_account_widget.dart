import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class TextCreateAccountWidget extends StatelessWidget {
  const TextCreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create account',
      style: AppTextStyles.authTitle(color: Colors.white),
    );
  }
}
