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

  // WeatherFlow login (dark city mock)
  static const authNightOverlay = Color(0xCC061018);
  static const authFieldFill = Color(0x66202633);
  static const authFieldBorder = Color(0x66FFFFFF);
  static const authHint = Color(0xFFB8C4D9);
  static const authOnDark = Color(0xFFFFFFFF);
  static const authMutedOnDark = Color(0xCCFFFFFF);
  static const authLinkBlue = Color(0xFF4DA3FF);
  static const authCtaStart = Color(0xFF2F7BFF);
  static const authCtaEnd = Color(0xFF1A5CFF);
  static const authGoogleBorder = Color(0x66FFFFFF);
  static const authGoogleFill = Color(0xE6111824);

  // WeatherFlow welcome (start mock)
  /// Single accent blue shared by "Flow", the Facebook tile and the Sign up CTA.
  static const welcomeAccentBlue = Color(0xFF5B9FE8);
  static const welcomeFlowBlue = welcomeAccentBlue;
  static const welcomeGreeting = Color(0xFFC2CAD6);
  static const welcomeSubtitle = Color(0xFFA8B2C0);
  static const welcomeGuest = Color(0xFF9AA4B2);
  static const welcomeDivider = Color(0x55FFFFFF);
  static const welcomeGlassFill = Color(0x00101820);
  static const welcomeGlassBorder = Color(0x2AC8D4E0);
  // Mock Sign up — horizontal sweep in the accent hue: deep navy edges,
  // accent-bright centre. Shades below are darker steps of welcomeAccentBlue.
  static const welcomeCtaEdge = Color(0xFF1B3F70);
  static const welcomeCtaTop = welcomeAccentBlue;
  static const welcomeCtaBottom = Color(0xFF3468AE);
  static const welcomeCtaGlow = Color(0xFF3C7AC8);

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
