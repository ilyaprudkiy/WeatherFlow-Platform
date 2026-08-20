import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

/// Glass input field used by Login and Sign up.
///
/// Same frosted treatment as [AuthGlassButton] so the form and the CTA read as
/// one material: the backdrop is gained up rather than covered with a
/// translucent fill, which would go flat grey over the near-black sky.
class AuthGlassField extends StatefulWidget {
  const AuthGlassField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscurable = false,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  /// Renders the trailing eye toggle and starts obscured.
  final bool obscurable;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<AuthGlassField> createState() => _AuthGlassFieldState();
}

class _AuthGlassFieldState extends State<AuthGlassField> {
  late bool _obscured = widget.obscurable;

  static const _radius = 15.0;
  static const _height = 50.0;

  /// Low gain so every field reads the same regardless of the sky behind it.
  static const _glassFilter = ColorFilter.matrix(<double>[
    1.14, 0.00, 0.00, 0, 8, //
    0.00, 1.14, 0.00, 0, 9,
    0.00, 0.00, 1.18, 0, 13,
    0.00, 0.00, 0.00, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(_radius);

    return SizedBox(
      height: _height,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.compose(
            outer: _glassFilter,
            inner: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          ),
          child: Container(
            foregroundDecoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: AppColors.welcomeGlassBorder,
                width: 0.9,
              ),
            ),
            child: TextField(
              controller: widget.controller,
              obscureText: _obscured,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              style: const TextStyle(
                color: AppColors.authOnDark,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: AppColors.welcomeAccentBlue,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.welcomeSubtitle,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(
                  widget.icon,
                  color: AppColors.welcomeSubtitle,
                  size: 18,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 42,
                  minHeight: 42,
                ),
                suffixIcon: widget.obscurable ? _eyeToggle() : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 42,
                  minHeight: 42,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _eyeToggle() {
    return GestureDetector(
      onTap: () => setState(() => _obscured = !_obscured),
      behavior: HitTestBehavior.opaque,
      child: Icon(
        _obscured
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: AppColors.welcomeSubtitle,
        size: 18,
      ),
    );
  }
}
