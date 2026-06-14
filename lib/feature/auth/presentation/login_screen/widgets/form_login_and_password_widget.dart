import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/theme/app_colors.dart';

class FormLoginAndPasswordWidget extends StatelessWidget {
  const FormLoginAndPasswordWidget(
      this.loginTextFieldController, this.passwordTextFieldController,
      {super.key});

  final TextEditingController loginTextFieldController;
  final TextEditingController passwordTextFieldController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: loginTextFieldController,
          hintText: 'Email',
          icon: Icons.perm_identity_outlined,
          prefixIconColor: AppColors.primary,
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: passwordTextFieldController,
          hintText: 'Password',
          icon: Icons.lock_open,
          prefixIconColor: AppColors.primary,
        ),
      ],
    );
  }
}
