import 'package:flutter/material.dart';
import 'package:weather_app/feature/auth/presentation/login_screen/login_screen.dart';
import 'package:weather_app/feature/auth/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:weather_app/feature/auth/presentation/welcome_screen/welcome_screen.dart';
import 'package:weather_app/feature/settings/presentation/screens/settings_screen/settings_screen.dart';
import 'package:weather_app/feature/weather/presentation/weather_main_shell/weather_main_shell.dart';

class ScreenFactory {
  Widget makeWelcomeScreen() => const WelcomeScreen();

  Widget makeLoginScreen() => const LoginScreenWidget();

  Widget makeSignUpScreen() => const SignUpScreenWidget();

  Widget makeWeatherScreen() => const WeatherMainShell();

  Widget makeSettingsScreen() => const SettingsScreen();
}
