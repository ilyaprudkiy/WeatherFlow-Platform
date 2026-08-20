import 'package:flutter/material.dart';
import '../theme/app_decorations.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.radius,
    this.color,
    this.padding,
  });

  final Widget child;
  final double? radius;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.card(color: color, radius: radius ?? 18),
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );
  }
}

class AppCardDivider extends StatelessWidget {
  const AppCardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1);
  }
}
