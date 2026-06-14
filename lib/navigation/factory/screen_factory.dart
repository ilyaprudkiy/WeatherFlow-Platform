import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/di/service_locator.dart';
import 'package:weather_app/feature/auth/presentation/login_screen/login_screen.dart';
import 'package:weather_app/feature/auth/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:weather_app/feature/auth/presentation/welcome_screen/welcome_screen.dart';
import 'package:weather_app/feature/settings/presentation/screens/settings_screen/settings_screen.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/weather_screen.dart';

class ScreenFactory {
  Widget makeWelcomeScreen() => const WelcomeScreen();

  Widget makeLoginScreen() => const LoginScreenWidget();

  Widget makeSignUpScreen() => const SignUpScreenWidget();

  Widget makeWeatherScreen() {
    return BlocProvider<WeatherScreenCubit>(
      create: (_) => sl<WeatherScreenCubit>(),
      child: const WeatherScreenWidget(),
    );
  }

  Widget makeSettingsScreen() => const SettingsScreen();
}
