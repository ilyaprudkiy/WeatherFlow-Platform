import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

/// "or continue with" divider + the three social tiles.
///
/// Shared by Welcome, Login and Sign up so the three screens cannot drift.
class AuthSocialRow extends StatelessWidget {
  const AuthSocialRow({super.key});

  static const _google = 'assets/images/social_google.png';
  static const _instagram = 'assets/images/social_instagram.png';
  static const _facebook = 'assets/images/social_facebook.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _OrDivider(),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialTile(asset: _google, onTap: () {}),
            const SizedBox(width: 10),
            _SocialTile(asset: _instagram, onTap: () {}),
            const SizedBox(width: 10),
            // Facebook glyph is a flat fill — tint it to the shared accent
            // so it matches "Flow" and the primary CTA.
            _SocialTile(
              asset: _facebook,
              tint: AppColors.welcomeAccentBlue,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: ColoredBox(
            color: AppColors.welcomeDivider,
            child: SizedBox(height: 1),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'or continue with',
            style: TextStyle(
              color: AppColors.welcomeSubtitle,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: AppColors.welcomeDivider,
            child: SizedBox(height: 1),
          ),
        ),
      ],
    );
  }
}

class _SocialTile extends StatelessWidget {
  const _SocialTile({required this.asset, required this.onTap, this.tint});

  final String asset;
  final VoidCallback onTap;
  final Color? tint;

  static const _size = 42.0;
  static const _radius = 12.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(_radius),
            child: Ink(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_radius),
                color: AppColors.welcomeGlassFill,
                border: Border.all(color: AppColors.welcomeGlassBorder),
              ),
              child: Center(child: _glyph()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glyph() {
    final image = Image.asset(
      asset,
      width: 22,
      height: 22,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
    final tint = this.tint;
    if (tint == null) {
      return image;
    }
    return ColorFiltered(
      colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
      child: image,
    );
  }
}
