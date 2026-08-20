import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

/// Welcome header — title + subtitle + brand icon asset (mock parity).
class WelcomeBrandHeader extends StatelessWidget {
  const WelcomeBrandHeader({super.key});

  static const iconCore = 'assets/images/wf_icon_core.png';
  static const iconAsset = iconCore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
              height: 1.05,
            ),
            children: [
              TextSpan(
                text: 'Weather',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'Flow',
                style: TextStyle(color: AppColors.welcomeFlowBlue),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Welcome back',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.welcomeGreeting,
            fontSize: 19,
            fontWeight: FontWeight.w400,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Choose an option to continue',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.welcomeSubtitle,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Image.asset(
          iconCore,
          width: 72,
          height: 72,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ],
    );
  }
}
