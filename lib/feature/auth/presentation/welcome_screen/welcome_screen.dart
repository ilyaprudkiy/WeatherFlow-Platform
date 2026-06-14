import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/feature/auth/presentation/welcome_screen/widgets/start_button_widget.dart';
import '../../../../core/config/configuration/network_icons/network_icons.dart';
import '../cubit/auth_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _welcomeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.welcomeGradientTop,
      AppColors.welcomeGradientBottom,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: _welcomeGradient),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listenWhen: (prev, current) => current is! UnknownState,
          listener: _onChangeWelcomeState,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    NetworkIcons.cloudIcons,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 1),
                  const LoginButtonWidget(),
                  const SizedBox(height: 10),
                  const SignUpButtonWidget(),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          NetworkIcons.googleIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          NetworkIcons.instagramIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          NetworkIcons.facebookIcon,
                          height: 20,
                          width: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_right_alt_sharp,
                      color: AppColors.guestLink,
                    ),
                    label: const Text(
                      'or continue as guest',
                      style: TextStyle(
                        color: AppColors.guestLink,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onChangeWelcomeState(BuildContext context, AuthState state) {
    if (state is AuthorizedState) {
      navigateToWeather(context);
    }
  }
}
