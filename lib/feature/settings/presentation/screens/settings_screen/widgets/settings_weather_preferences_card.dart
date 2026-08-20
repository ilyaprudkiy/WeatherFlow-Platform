import 'package:flutter/material.dart';
import 'settings_card.dart';
import 'settings_constants.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';
import 'settings_profile_row.dart';
import 'settings_rows.dart';

class SettingsWeatherPreferencesCard extends StatelessWidget {
  const SettingsWeatherPreferencesCard({
    super.key,
    required this.expanded,
    required this.displayName,
    required this.weatherAlerts,
    required this.useCelsius,
    required this.darkMode,
    required this.onToggleExpanded,
    required this.onWeatherAlertsChanged,
    required this.onUseCelsiusChanged,
    required this.onDarkModeChanged,
    required this.onAccountTap,
    required this.onDefaultLocationTap,
  });

  final bool expanded;
  final String displayName;
  final bool weatherAlerts;
  final bool useCelsius;
  final bool darkMode;
  final VoidCallback onToggleExpanded;
  final ValueChanged<bool> onWeatherAlertsChanged;
  final ValueChanged<bool> onUseCelsiusChanged;
  final ValueChanged<bool> onDarkModeChanged;
  final VoidCallback onAccountTap;
  final VoidCallback onDefaultLocationTap;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        children: [
          InkWell(
            onTap: onToggleExpanded,
            borderRadius: BorderRadius.circular(settingsCardRadius),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 14, 18),
              child: Row(
                children: [
                  Text(
                    'Weather Preferences',
                    style: AppTextStyles.settingsSectionTitle,
                  ),
                  const Spacer(),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
          if (expanded) ...[
            const SettingsCardDivider(),
            SettingsProfileRow(name: displayName),
            const SettingsCardDivider(),
            SettingsLabelRow(
              label: 'Account',
              onTap: onAccountTap,
            ),
            const SettingsCardDivider(),
            SettingsLabelRow(
              label: 'Default Location',
              onTap: onDefaultLocationTap,
            ),
            const SettingsCardDivider(),
            SettingsSwitchRow(
              label: 'Weather Alerts',
              value: weatherAlerts,
              onChanged: onWeatherAlertsChanged,
            ),
            const SettingsCardDivider(),
            SettingsSwitchRow(
              label: 'Use Celsius (°C)',
              value: useCelsius,
              onChanged: onUseCelsiusChanged,
            ),
            const SettingsCardDivider(),
            SettingsSwitchRow(
              label: 'Dark Mode',
              value: darkMode,
              onChanged: onDarkModeChanged,
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}
