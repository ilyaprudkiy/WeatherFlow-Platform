import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle authTitle({Color color = AppColors.primaryDark}) =>
      GoogleFonts.poppins(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle authSubtitle({Color color = AppColors.primaryDark}) =>
      GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle primaryButton({Color color = AppColors.onPrimary}) =>
      GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle secondaryButton({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle sectionTitle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle sectionLink = const TextStyle(
    color: AppColors.primary,
    fontSize: 14,
  );

  static TextStyle settingsScreenTitle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle settingsSectionTitle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle settingsRow = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle settingsProfileName = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle weatherCity = GoogleFonts.abrilFatface(
    color: AppColors.onPrimary,
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  static TextStyle weatherTemperature = GoogleFonts.aBeeZee(
    color: AppColors.onPrimary,
    fontSize: 64,
    fontWeight: FontWeight.w400,
    height: 1,
  );

  static const weatherCaption = TextStyle(
    fontSize: 14,
    color: AppColors.weatherCaption,
  );
}
