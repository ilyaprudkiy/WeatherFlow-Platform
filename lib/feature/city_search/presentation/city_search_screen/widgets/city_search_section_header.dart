import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class CitySearchSectionHeader extends StatelessWidget {
  const CitySearchSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.settingsRow.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionLabel!,
                style: AppTextStyles.sectionLink,
              ),
            ),
        ],
      ),
    );
  }
}
