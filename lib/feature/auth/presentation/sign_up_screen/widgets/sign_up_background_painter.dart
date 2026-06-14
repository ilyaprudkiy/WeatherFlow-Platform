import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

class SignUpBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint();

    final mainBackground = Path()
      ..lineTo(width, 0)
      ..lineTo(width, height * 0.65)
      ..cubicTo(width * 0.8, height * 0.8, width * 0.5, height * 0.8,
          width * 0.45, height)
      ..lineTo(0, height);

    paint.color = AppColors.primaryDark;
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
