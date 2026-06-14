import 'package:flutter/material.dart';
import 'package:weather_app/core/widgets/app_icon_button.dart';
import 'package:weather_app/navigation/navigation.dart';

class TopAppBarWidget extends StatelessWidget {
  const TopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          AppIconCircleButton(
            icon: Icons.menu,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(MainNavigationRouteNames.settingsScreen);
            },
          ),
          const Spacer(),
          AppIconCircleButton(
            icon: Icons.star_border,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
