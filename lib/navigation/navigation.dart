import 'package:flutter/material.dart';
import 'factory/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const welcomeScreen = '/';
  static const signUpScreen = '/sign_up_screen';
  static const loginScreen = '/login_screen';
  static const weatherScreen = '/weather_screen';
  static const settingsScreen = '/weather_screen/settings_screen';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.welcomeScreen: (_) =>
        _screenFactory.makeWelcomeScreen(),
    MainNavigationRouteNames.weatherScreen: (context) =>
        _screenFactory.getWeather(context),
    MainNavigationRouteNames.signUpScreen: (context) =>
        _screenFactory.signUpScreen(context),
    MainNavigationRouteNames.loginScreen: (_) => _screenFactory.loginScreen(),
    MainNavigationRouteNames.settingsScreen: (context) =>
        _screenFactory.makeSettingsScreen(context)
  };
}
