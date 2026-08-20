import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 40.0;

  static const screenHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const cardPadding = EdgeInsets.symmetric(horizontal: 18, vertical: 18);
  static const textFieldPadding =
      EdgeInsets.symmetric(vertical: 10, horizontal: 25);
}
