import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

class MyCirclePainter extends CustomPainter {
  final double radius;

  MyCirclePainter({super.repaint, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = AppColors.primaryDark;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 3, size.height / 3), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyCustomPaint extends StatelessWidget {
  final double? width;
  final double? height;
  final double? left;
  final double? right;
  final double? bottom;
  final double? top;
  final double radius;
  final Size size;
  final double? sizeWidth;
  final double? sizeHeight;

  const MyCustomPaint({
    super.key,
    this.left,
    this.right,
    this.bottom,
    this.top,
    required this.radius,
    required this.size,
    this.width,
    this.height,
    this.sizeWidth,
    this.sizeHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        width: width,
        height: height,
        left: left,
        bottom: bottom,
        top: top,
        right: right,
        child: CustomPaint(
          painter: MyCirclePainter(radius: radius),
          size: size,
        ));
  }
}
