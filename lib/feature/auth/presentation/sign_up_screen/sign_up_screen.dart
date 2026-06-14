import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/auth_navigation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/auth_cubit.dart';
import 'widgets/button_sign_up_widget.dart';
import 'widgets/sign_up_background_painter.dart';
import 'widgets/text_create_account_widget.dart';

class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({super.key});

  @override
  State<SignUpScreenWidget> createState() => _SignUpScreenWidgetState();
}

class _SignUpScreenWidgetState extends State<SignUpScreenWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: CustomPaint(
        painter: SignUpBackgroundPainter(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _onChangeSignUpState,
          builder: (context, state) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      const TextCreateAccountWidget(),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                        prefixIconColor: AppColors.primaryDark,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_open_outlined,
                        prefixIconColor: AppColors.primaryDark,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: _repeatPasswordController,
                        hintText: 'Repeat password',
                        icon: Icons.password_outlined,
                        prefixIconColor: AppColors.primaryDark,
                      ),
                      const SizedBox(height: 20),
                      ButtonSignUpWidget(
                        email: _emailController,
                        password: _passwordController,
                        repeatPassword: _repeatPasswordController,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onChangeSignUpState(BuildContext context, AuthState state) {
    if (state is ErrorState) {
      context.showErrorSnackBar(state.message);
    } else if (state is AuthorizedState) {
      navigateToWeather(context);
    }
  }
}
