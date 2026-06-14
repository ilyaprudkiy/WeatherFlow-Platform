import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: AppTextStyles.settingsScreenTitle.color,
          ),
          Text('Settings', style: AppTextStyles.settingsScreenTitle),
        ],
      ),
    );
  }
}
