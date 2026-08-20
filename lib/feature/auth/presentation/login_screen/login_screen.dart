import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/widgets/app_snackbar.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/auth/presentation/widgets/auth_glass_button.dart';
import 'package:weather_app/feature/auth/presentation/widgets/auth_glass_field.dart';
import 'package:weather_app/feature/auth/presentation/widgets/auth_scaffold.dart';
import 'package:weather_app/feature/auth/presentation/widgets/auth_social_row.dart';
import 'package:weather_app/navigation/navigation.dart';

/// Login screen — same glass language as Welcome, no brand tile.
class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _changeStateScreen,
      builder: (context, state) {
        final isLoading = state is LoadingState;

        return AuthScaffold(
          title: 'Welcome back',
          subtitle: 'Please enter your details.',
          child: Column(
            children: [
              AuthGlassField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              AuthGlassField(
                controller: _passwordController,
                hintText: 'Password',
                icon: Icons.lock_outline_rounded,
                obscurable: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot-password flow not wired yet — keep CTA for parity.
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.welcomeAccentBlue,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AuthGlassButton(
                label: 'Log in',
                icon: Icons.person_outline_rounded,
                accented: true,
                height: 48,
                busy: isLoading,
                onPressed: () => context.read<AuthCubit>().login(
                      _emailController.text.trim(),
                      _passwordController.text,
                    ),
              ),
              const SizedBox(height: 24),
              const AuthSocialRow(),
              const SizedBox(height: 22),
              const _SignUpPrompt(),
            ],
          ),
        );
      },
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

class _SignUpPrompt extends StatelessWidget {
  const _SignUpPrompt();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: AppColors.welcomeSubtitle,
            fontSize: 13,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacementNamed(
            MainNavigationRouteNames.signUpScreen,
          ),
          child: const Text(
            'Sign up',
            style: TextStyle(
              color: AppColors.welcomeAccentBlue,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
