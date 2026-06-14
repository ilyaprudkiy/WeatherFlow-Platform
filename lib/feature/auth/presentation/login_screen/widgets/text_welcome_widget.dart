import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class TextWelcomeWidget extends StatelessWidget {
  const TextWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 150,
      top: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome', style: AppTextStyles.authTitle()),
                Text('Back!', style: AppTextStyles.authSubtitle()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
