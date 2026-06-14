import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_shadows.dart';

abstract final class AppDecorations {
  static BoxDecoration card({Color? color, double radius = AppRadius.lg}) =>
      BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: AppShadows.card(),
      );

  static BoxDecoration forecastListCard = BoxDecoration(
    color: AppColors.forecastBackground,
    borderRadius: BorderRadius.circular(AppRadius.xxl),
    border: Border.all(color: AppColors.forecastBorder),
    boxShadow: AppShadows.card(alpha: 0.05),
  );

  static BoxDecoration weatherMetricsCard = BoxDecoration(
    color: AppColors.weatherSlateWithAlpha(0.95),
    borderRadius: BorderRadius.circular(AppRadius.md),
    border: Border.all(color: AppColors.weatherSlateWithAlpha(0.65)),
  );

  static BoxDecoration iconCircleButton = BoxDecoration(
    color: AppColors.weatherSlateWithAlpha(0.65),
    shape: BoxShape.circle,
  );
}
