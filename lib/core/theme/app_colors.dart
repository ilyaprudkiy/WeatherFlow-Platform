import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Colors.blueAccent;
  static const primaryDark = Color(0xFF1565C0);
  static const onPrimary = Colors.white;

  static const textPrimary = Colors.black87;
  static const textSecondary = Colors.black54;
  static const textMuted = Colors.black45;
  static const textLink = Colors.blue;

  static const scaffold = Colors.white;
  static const surface = Colors.white;

  // Auth
  static const welcomeGradientTop = Color(0xFFE0EAFC);
  static const welcomeGradientBottom = Color(0xFFCFDEF3);
  static const authButtonGradientStart = Color(0xFF8DA7C3);
  static const authButtonGradientEnd = Color(0xFFAFC1D6);
  static const guestLink = Colors.lightBlue;

  // Settings
  static const settingsBackground = Color(0xFFF3F4F6);
  static const avatarBackground = Color(0xFFE8E8ED);
  static const switchInactiveTrack = Color(0xFFE5E7EB);
  static const switchInactiveThumb = Color(0xFF374151);

  // Weather
  static const weatherSlate = Color(0xFF3D5873);
  static const weatherNavy = Color(0xFF061B35);
  static const hourlyBlue = Color(0xFF42A5F5);
  static const forecastBackground = Color(0xFFF4F7FA);
  static const forecastBorder = Color(0xFFE3EBF3);
  static const forecastBarStart = Color(0xFF4FC3F7);
  static const forecastBarEnd = Color(0xFF1565C0);
  static const weatherCaption = Colors.white70;
  static const bottomNavInactive = Color(0xFFB8C9D9);

  static Color weatherSlateWithAlpha(double alpha) =>
      weatherSlate.withValues(alpha: alpha);
}
