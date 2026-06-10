import 'package:flutter/material.dart';

class GradientWeatherScreenWidget extends StatelessWidget {
  const GradientWeatherScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
        bottom: 170,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.55,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000), // прозрачный
                Color(0x00000000), // лёгкое затемнение
                Color(0xFF061B35), // глубокое
                Color(0xFF061B35), // почти полностью тёмный
              ],
            ),
          ),
        ),
      ),

      Positioned(
        left: 0,
        top: 0,
        bottom: 180,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.55,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF061B35),
                Color(0x00061B35),
              ],
            ),
          ),
        ),
      ),


    ],);
  }
}