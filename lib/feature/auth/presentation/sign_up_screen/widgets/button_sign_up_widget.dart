import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/widgets/app_buttons.dart';
import '../../cubit/auth_cubit.dart';

class ButtonSignUpWidget extends StatelessWidget {
  const ButtonSignUpWidget({
    super.key,
    required this.email,
    required this.password,
    required this.repeatPassword,
  });

  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController repeatPassword;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return AppSecondaryButton(
      label: 'Sign up',
      onPressed: () {
        cubit.signUp(email.text, password.text, repeatPassword.text);
      },
    );
  }
}
