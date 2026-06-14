import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/auth/presentation/login_screen/widgets/form_button_login_forgot_widget.dart';
import 'package:weather_app/feature/auth/presentation/login_screen/widgets/form_continue_with_widget.dart';
import 'package:weather_app/feature/auth/presentation/login_screen/widgets/form_login_and_password_widget.dart';
import 'package:weather_app/feature/auth/presentation/login_screen/widgets/text_welcome_widget.dart';
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/widgets/app_snackbar.dart';
import '../../../../core/constant/widgets/custom_painter.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const MyCustomPaint(
                radius: 150,
                size: Size(300, 300),
                width: 10,
                height: 10,
                left: 20),
            const MyCustomPaint(
              radius: 20,
              size: Size(150, 150),
              left: 300,
              top: 20,
            ),
            const MyCustomPaint(
              radius: 30,
              size: Size(200, 200),
              left: 330,
              top: 50,
            ),
            const MyCustomPaint(
              radius: 30,
              size: Size(200, 200),
              left: 200,
              top: 10,
            ),
            const TextWelcomeWidget(),
            BlocConsumer<AuthCubit, AuthState>(
                listener: _changeStateScreen,
                builder: (context, state) {
                  return SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: Column(
                          children: [
                            FormLoginAndPasswordWidget(
                                _emailController, _passwordController),
                            const SizedBox(
                              height: 30,
                            ),
                            FormButtonLoginForgotWidget(
                              _emailController,
                              _passwordController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const FormContinueWithWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  void _changeStateScreen(BuildContext context, AuthState state) {
    if (state is AuthorizedState) {
      navigateToWeather(context);
    } else if (state is ErrorState) {
      context.showErrorSnackBar(state.message);
    }
  }
}
