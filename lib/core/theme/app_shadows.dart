import 'package:flutter/material.dart';

abstract final class AppShadows {
  static List<BoxShadow> card({double alpha = 0.06, double blur = 16}) => [
        BoxShadow(
          color: Colors.black.withValues(alpha: alpha),
          blurRadius: blur,
          offset: const Offset(0, 4),
        ),
      ];
}
