import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

/// Shared glass button for every auth screen (Welcome, Login, Sign up).
///
/// The sky behind these screens is almost black, so a translucent fill — or a
/// `screen` tint — either sinks into it and reads as flat grey, or flattens the
/// luminance and hides the clouds entirely. Instead the backdrop itself is
/// gained up so cloud detail becomes visible; [accented] additionally drives
/// the blue channel hard, turning that cloud luminance into a range from deep
/// navy to bright accent blue.
class AuthGlassButton extends StatelessWidget {
  const AuthGlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.accented = false,
    this.height = 40,
    this.busy = false,
  });

  final String label;

  /// Null when the mock shows a bare label (Login / Sign up CTAs).
  final IconData? icon;
  final VoidCallback? onPressed;

  /// Blue-tinted primary action. Plain glass otherwise.
  final bool accented;
  final double height;
  final bool busy;

  static const _radius = 15.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(_radius);
    final enabled = onPressed != null && !busy;

    return Opacity(
      opacity: enabled ? 1 : 0.55,
      child: _surface(radius, enabled),
    );
  }

  Widget _surface(BorderRadius radius, bool enabled) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: accented
              ? [
                  BoxShadow(
                    color: AppColors.welcomeCtaGlow.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: BackdropFilter(
            filter: _backdrop,
            child: Container(
              foregroundDecoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(
                  color: accented
                      ? AppColors.welcomeAccentBlue.withValues(alpha: 0.42)
                      : AppColors.welcomeGlassBorder,
                  width: 0.9,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: enabled ? onPressed : null,
                  borderRadius: radius,
                  child: Center(child: _content()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    if (busy) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.authOnDark,
        ),
      );
    }

    final text = Text(
      label,
      style: const TextStyle(
        color: AppColors.authOnDark,
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
      ),
    );
    final icon = this.icon;
    if (icon == null) {
      return text;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.authOnDark, size: 15),
        const SizedBox(width: 7),
        text,
      ],
    );
  }

  ImageFilter get _backdrop {
    final blur = ImageFilter.blur(sigmaX: 4, sigmaY: 4);
    return ImageFilter.compose(
      outer: accented ? _blueGlassFilter : _clearGlassFilter,
      inner: blur,
    );
  }

  static const _clearGlassFilter = ColorFilter.matrix(<double>[
    1.30, 0.00, 0.00, 0, 8, //
    0.00, 1.30, 0.00, 0, 10,
    0.00, 0.00, 1.34, 0, 14,
    0.00, 0.00, 0.00, 1, 0,
  ]);

  /// Gains kept low on purpose: a steeper blue curve clips to a flat, solid
  /// blue wherever the sky behind the button is lighter.
  static const _blueGlassFilter = ColorFilter.matrix(<double>[
    1.00, 0.00, 0.00, 0, 0, //
    0.00, 1.18, 0.00, 0, 4,
    0.00, 0.00, 2.05, 0, 22,
    0.00, 0.00, 0.00, 1, 0,
  ]);
}
