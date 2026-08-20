import 'package:flutter/material.dart';
import 'package:weather_app/feature/auth/presentation/widgets/auth_glass_button.dart';
import 'package:weather_app/navigation/navigation.dart';

class WelcomeLoginButton extends StatelessWidget {
  const WelcomeLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGlassButton(
      label: 'Log in',
      icon: Icons.person_outline_rounded,
      onPressed: () {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.loginScreen);
      },
    );
  }
}

class WelcomeSignUpButton extends StatelessWidget {
  const WelcomeSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGlassButton(
      label: 'Sign up',
      icon: Icons.person_add_alt_1_rounded,
      accented: true,
      onPressed: () {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.signUpScreen);
      },
    );
  }
}
