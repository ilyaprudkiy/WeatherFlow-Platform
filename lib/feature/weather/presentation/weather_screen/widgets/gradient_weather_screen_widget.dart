import 'package:flutter/material.dart';

class GradientWeatherScreenWidget extends StatelessWidget {
  const GradientWeatherScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.35, 0.75, 1.0],
          colors: [
            Color(0x22061B35),
            Color(0x55061B35),
            Color(0xCC061B35),
            Color(0xFF061B35),
          ],
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: 0.55,
          heightFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF061B35).withValues(alpha: 0.85),
                  const Color(0xFF061B35).withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
