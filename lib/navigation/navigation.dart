import 'package:flutter/material.dart';
import 'factory/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const welcomeScreen = '/';
  static const signUpScreen = '/sign_up';
  static const loginScreen = '/login';
  static const weatherScreen = '/weather';
  static const settingsScreen = '/settings';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.welcomeScreen: (_) =>
        _screenFactory.makeWelcomeScreen(),
    MainNavigationRouteNames.weatherScreen: (_) =>
        _screenFactory.makeWeatherScreen(),
    MainNavigationRouteNames.signUpScreen: (_) =>
        _screenFactory.makeSignUpScreen(),
    MainNavigationRouteNames.loginScreen: (_) =>
        _screenFactory.makeLoginScreen(),
    MainNavigationRouteNames.settingsScreen: (_) =>
        _screenFactory.makeSettingsScreen(),
  };
}
