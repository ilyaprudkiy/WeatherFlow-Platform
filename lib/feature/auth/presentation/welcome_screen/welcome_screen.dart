import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/auth/presentation/welcome_screen/widgets/welcome_auth_buttons.dart';
import 'package:weather_app/feature/auth/presentation/welcome_screen/widgets/welcome_brand_header.dart';
import 'package:weather_app/feature/auth/presentation/welcome_screen/widgets/welcome_social_row.dart';

/// Welcome — mock layout; bg city pinned to bottom like reference.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _bgPrimary = 'assets/images/weatherflow_rain_bg.png';
  static const _bgFallback = 'assets/images/new_york.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Mock bg: sky on top, city along the bottom edge.
          Image.asset(
            _bgPrimary,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            filterQuality: FilterQuality.high,
            errorBuilder: (_, __, ___) => Image.asset(
              _bgFallback,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              filterQuality: FilterQuality.high,
            ),
          ),
          // Soft readability only — keep city lights at bottom visible.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66000000),
                  Color(0x22000000),
                  Color(0x00000000),
                  Color(0x66000000),
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: BlocListener<AuthCubit, AuthState>(
              listenWhen: (prev, current) => current is AuthorizedState,
              listener: _onChangeWelcomeState,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                child: Column(
                  children: [
                    Spacer(flex: 4),
                    WelcomeBrandHeader(),
                    SizedBox(height: 12),
                    // Mock: action stack is noticeably narrower than the screen.
                    FractionallySizedBox(
                      widthFactor: 0.74,
                      child: Column(
                        children: [
                          WelcomeLoginButton(),
                          SizedBox(height: 7),
                          WelcomeSignUpButton(),
                          SizedBox(height: 10),
                          WelcomeSocialRow(),
                          SizedBox(height: 4),
                          _GuestButton(),
                        ],
                      ),
                    ),
                    Spacer(flex: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChangeWelcomeState(BuildContext context, AuthState state) {
    if (state is AuthorizedState) {
      navigateToWeather(context);
    }
  }
}

class _GuestButton extends StatelessWidget {
  const _GuestButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => navigateToWeather(context),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.welcomeGuest,
        padding: const EdgeInsets.symmetric(vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'Continue as guest',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
