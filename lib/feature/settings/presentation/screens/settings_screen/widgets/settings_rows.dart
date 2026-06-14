import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class SettingsLabelRow extends StatelessWidget {
  const SettingsLabelRow({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.settingsRow)),
              if (onTap != null)
                Icon(Icons.chevron_right, color: Colors.grey.shade500),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSwitchRow extends StatelessWidget {
  const SettingsSwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 12, 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyles.settingsRow)),
          Switch.adaptive(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
