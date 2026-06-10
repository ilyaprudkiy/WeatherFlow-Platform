import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/settings/presentation/screens/settings_screen/settings_screen.dart';
import '../../core/di/service_locator.dart';
import '../../feature/auth/presentation/login_screen/login_screen.dart';
import '../../feature/auth/presentation/sign_up_screen/sign_up_screen.dart';
import '../../feature/auth/presentation/welcome_screen/welcome_screen.dart';
import '../../feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import '../../feature/weather/presentation/weather_screen/weather_screen.dart';

class ScreenFactory {


  Widget loginScreen() {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      lazy: false,
      child: const LoginScreenWidget(),
    );
  }

  Widget makeWelcomeScreen() {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      lazy: false,
      child: const WelcomeScreen(),
    );
  }

  Widget signUpScreen(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      lazy: false,
      child: const SignUpScreenWidget(),
    );
  }

  Widget getWeather(BuildContext context) {
    return BlocProvider<WeatherScreenCubit>(
      create: (context) => sl<WeatherScreenCubit>(),
      child: const WeatherScreenWidget(),
    );
  }


    Widget makeSettingsScreen(BuildContext context) {
      return BlocProvider<AuthCubit>(
        create: (context) => sl<AuthCubit>(),
        lazy: false,
        child: SettingsScreen(),
      );
    }
  }
