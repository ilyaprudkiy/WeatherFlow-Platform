import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';
import 'package:weather_app/core/widgets/app_buttons.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';

class FormButtonLoginForgotWidget extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const FormButtonLoginForgotWidget(this.email, this.password, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppPrimaryButton(
            label: 'Login',
            onPressed: () => cubit.login(email.text, password.text),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password? ',
              style: AppTextStyles.primaryButton(color: AppColors.textLink),
            ),
          ),
        )
      ],
    );
  }
}
