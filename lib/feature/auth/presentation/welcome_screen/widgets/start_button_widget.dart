import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import '../../../../../navigation/navigation.dart';
import '../../../../../core/widgets/app_icon_button.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  static const _gradient = LinearGradient(colors: [
    AppColors.authButtonGradientStart,
    AppColors.authButtonGradientEnd,
  ]);

  @override
  Widget build(BuildContext context) {
    return AppGradientButton(
      label: 'Sign up',
      gradientColors: _gradient.colors,
      backgroundColor: AppColors.primary.withValues(alpha: 0.6),
      onPressed: () {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.signUpScreen);
      },
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  static const _gradient = LinearGradient(colors: [
    AppColors.surface,
    AppColors.authButtonGradientEnd,
  ]);

  @override
  Widget build(BuildContext context) {
    return AppGradientButton(
      label: 'Login',
      gradientColors: _gradient.colors,
      textColor: AppColors.primary.withValues(alpha: 0.7),
      onPressed: () {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.loginScreen);
      },
    );
  }
}
