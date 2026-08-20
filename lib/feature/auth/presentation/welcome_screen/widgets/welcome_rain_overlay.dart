import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Rain on glass — droplets sitting on the screen (iPhone Weather style).
class WelcomeRainOverlay extends StatefulWidget {
  const WelcomeRainOverlay({super.key});

  @override
  State<WelcomeRainOverlay> createState() => _WelcomeRainOverlayState();
}

class _WelcomeRainOverlayState extends State<WelcomeRainOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_GlassDrop> _drops;

  @override
  void initState() {
    super.initState();
    final rnd = math.Random(11);
    _drops = List.generate(56, (i) {
      final large = i < 10;
      return _GlassDrop(
        x: rnd.nextDouble(),
        y: rnd.nextDouble(),
        radius: large
            ? 5.5 + rnd.nextDouble() * 7
            : 1.6 + rnd.nextDouble() * 3.2,
        dripSpeed: large ? 0.015 + rnd.nextDouble() * 0.03 : 0,
        wobble: rnd.nextDouble() * math.pi * 2,
        highlightAngle: -0.7 + rnd.nextDouble() * 0.4,
      );
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _GlassRainPainter(drops: _drops, t: _controller.value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _GlassDrop {
  const _GlassDrop({
    required this.x,
    required this.y,
    required this.radius,
    required this.dripSpeed,
    required this.wobble,
    required this.highlightAngle,
  });

  final double x;
  final double y;
  final double radius;
  final double dripSpeed;
  final double wobble;
  final double highlightAngle;
}

class _GlassRainPainter extends CustomPainter {
  _GlassRainPainter({required this.drops, required this.t});

  final List<_GlassDrop> drops;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Soft wet-glass veil
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0x140A1424),
    );

    for (final d in drops) {
      final drip = d.dripSpeed > 0 ? (t * d.dripSpeed * 8) % 1.15 : 0.0;
      final cx = d.x * size.width + math.sin(t * math.pi * 2 + d.wobble) * 1.2;
      final cy = ((d.y + drip) % 1.08) * size.height;
      final r = d.radius;

      // Body — translucent lens on glass
      final bodyPaint = Paint()
        ..shader = ui.Gradient.radial(
          Offset(cx - r * 0.25, cy - r * 0.35),
          r * 1.15,
          [
            Colors.white.withValues(alpha: 0.42),
            Colors.white.withValues(alpha: 0.16),
            Colors.white.withValues(alpha: 0.05),
          ],
          const [0.0, 0.45, 1.0],
        );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, cy),
          width: r * 1.7,
          height: r * 2.05,
        ),
        bodyPaint,
      );

      // Dark rim for depth on glass
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, cy + 0.4),
          width: r * 1.7,
          height: r * 2.05,
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.7
          ..color = Colors.black.withValues(alpha: 0.18),
      );

      // Specular highlight (iOS-style)
      final hx = cx + math.cos(d.highlightAngle) * r * 0.35;
      final hy = cy + math.sin(d.highlightAngle) * r * 0.45 - r * 0.15;
      canvas.drawCircle(
        Offset(hx, hy),
        r * 0.28,
        Paint()..color = Colors.white.withValues(alpha: 0.75),
      );
      canvas.drawCircle(
        Offset(hx + r * 0.15, hy + r * 0.2),
        r * 0.12,
        Paint()..color = Colors.white.withValues(alpha: 0.35),
      );

      // Thin drip trail under larger drops
      if (d.dripSpeed > 0 && r > 6) {
        final trail = Paint()
          ..shader = ui.Gradient.linear(
            Offset(cx, cy + r),
            Offset(cx, cy + r * 3.2),
            [
              Colors.white.withValues(alpha: 0.22),
              Colors.white.withValues(alpha: 0.0),
            ],
          )
          ..strokeWidth = r * 0.35
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(cx, cy + r * 0.9),
          Offset(cx - 0.5, cy + r * 3.0),
          trail,
        );
      }

      // Tiny secondary speck near big drops
      if (r > 7) {
        canvas.drawCircle(
          Offset(cx + r * 1.1, cy + r * 0.6),
          r * 0.22,
          Paint()..color = Colors.white.withValues(alpha: 0.28),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GlassRainPainter oldDelegate) =>
      oldDelegate.t != t;
}
