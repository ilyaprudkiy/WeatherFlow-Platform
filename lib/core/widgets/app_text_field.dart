import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.prefixIconColor = AppColors.primary,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.textFieldPadding,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: AppColors.surface,
          filled: true,
          prefixIcon: Icon(icon, color: prefixIconColor),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
      ),
    );
  }
}
