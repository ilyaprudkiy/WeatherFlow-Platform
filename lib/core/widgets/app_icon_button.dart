import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.gradientColors,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
    this.minWidth = 160,
    this.maxWidth = 180,
    this.height = 50,
  });

  final String label;
  final VoidCallback? onPressed;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final Color textColor;
  final double minWidth;
  final double maxWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.authButton),
          gradient: LinearGradient(colors: gradientColors),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(minWidth, height),
            maximumSize: Size(maxWidth, height + 20),
            backgroundColor: backgroundColor,
            shadowColor: backgroundColor == Colors.transparent
                ? Colors.transparent
                : null,
            padding: const EdgeInsets.all(10),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class AppIconCircleButton extends StatelessWidget {
  const AppIconCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor = AppColors.primary,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(13),
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color iconColor;
  final Color? backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? AppColors.weatherSlateWithAlpha(0.65),
        shape: const CircleBorder(),
        padding: padding,
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}
