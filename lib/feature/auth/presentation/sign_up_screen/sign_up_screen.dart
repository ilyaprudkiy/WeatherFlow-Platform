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

/// Sign up screen — same glass language as Welcome / Login, no brand tile.
class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({super.key});

  @override
  State<SignUpScreenWidget> createState() => _SignUpScreenWidgetState();
}

class _SignUpScreenWidgetState extends State<SignUpScreenWidget> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _onChangeSignUpState,
      builder: (context, state) {
        final isLoading = state is LoadingState;

        return AuthScaffold(
          title: 'Create your account',
          subtitle: "Let's get you started.",
          child: Column(
            children: [
              AuthGlassField(
                controller: _nameController,
                hintText: 'Full name',
                icon: Icons.person_outline_rounded,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              AuthGlassField(
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                icon: Icons.lock_outline_rounded,
                obscurable: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 14),
              _TermsCheckbox(
                value: _acceptedTerms,
                onChanged: (value) => setState(() => _acceptedTerms = value),
              ),
              const SizedBox(height: 16),
              AuthGlassButton(
                label: 'Create account',
                icon: Icons.person_add_alt_1_rounded,
                accented: true,
                height: 48,
                busy: isLoading,
                onPressed: _submit,
              ),
              const SizedBox(height: 24),
              const AuthSocialRow(),
              const SizedBox(height: 22),
              const _LoginPrompt(),
            ],
          ),
        );
      },
    );
  }

  void _submit() {
    if (!_acceptedTerms) {
      context.showErrorSnackBar(
        'Please accept the Terms of Service and Privacy Policy.',
      );
      return;
    }
    context.read<AuthCubit>().signUp(
          _emailController.text.trim(),
          _passwordController.text,
          _confirmPasswordController.text,
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

class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(top: 1, right: 8),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: value
                    ? AppColors.welcomeAccentBlue.withValues(alpha: 0.85)
                    : Colors.transparent,
                border: Border.all(
                  color: value
                      ? AppColors.welcomeAccentBlue
                      : AppColors.welcomeGlassBorder,
                  width: 1,
                ),
              ),
              child: value
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                color: AppColors.welcomeSubtitle,
                fontSize: 12.5,
                height: 1.35,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(color: AppColors.welcomeAccentBlue),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: AppColors.welcomeAccentBlue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            color: AppColors.welcomeSubtitle,
            fontSize: 13,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacementNamed(
            MainNavigationRouteNames.loginScreen,
          ),
          child: const Text(
            'Log in',
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
