import 'package:flutter/material.dart';
import 'package:weather_app/navigation/navigation.dart';

class TopAppBarWidget extends StatelessWidget {
  const TopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: EdgeInsets.only(),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(MainNavigationRouteNames.settingsScreen);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D5873).withValues(alpha: 0.65),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(13)),
          child: const Icon(
            Icons.menu,
            color: Colors.blueAccent,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 280),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3D5873).withValues(alpha: 0.65),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(13),
          ),
          child: const Icon(
            Icons.star_border,
            color: Colors.blueAccent,
          ),
        ),
      ),
    ]);
  }
}
