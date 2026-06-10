import 'package:flutter/material.dart';

const _barColor = Color(0xB33D5873);
const _selectedBlue = Colors.blueAccent;
const _inactiveBlue = Color(0xFFB8C9D9);

class WeatherBottomNavBar extends StatefulWidget {
  const WeatherBottomNavBar({super.key});

  @override
  State<WeatherBottomNavBar> createState() => _WeatherBottomNavBarState();
}

class _WeatherBottomNavBarState extends State<WeatherBottomNavBar> {
  int _selectedIndex = 0;

  static const _barHeight = 40.0;
  static const _notchWidth = 78.0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: _barHeight + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: Size(width, _barHeight + bottomInset),
            painter: _NotchedBarPainter(bottomInset: bottomInset),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            height: _barHeight,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavIconButton(
                        index: 0,
                        selectedIndex: _selectedIndex,
                        icon: Icons.home_outlined,
                        selectedIcon: Icons.home_rounded,
                        onTap: _select,
                      ),
                      _NavIconButton(
                        index: 1,
                        selectedIndex: _selectedIndex,
                        icon: Icons.search_rounded,
                        selectedIcon: Icons.search_rounded,
                        onTap: _select,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: _notchWidth),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavIconButton(
                        index: 2,
                        selectedIndex: _selectedIndex,
                        icon: Icons.bookmark_outline_rounded,
                        selectedIcon: Icons.bookmark_rounded,
                        onTap: _select,
                      ),
                      _NavIconButton(
                        index: 3,
                        selectedIndex: _selectedIndex,
                        icon: Icons.insights_outlined,
                        selectedIcon: Icons.insights_rounded,
                        onTap: _select,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _select(int index) {
    setState(() => _selectedIndex = index);
  }
}

class _NavIconButton extends StatelessWidget {
  const _NavIconButton({
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final IconData icon;
  final IconData selectedIcon;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            isSelected ? selectedIcon : icon,
            size: 22,
            color: isSelected ? _selectedBlue : _inactiveBlue,
          ),
        ),
      ),
    );
  }
}

class _NotchedBarPainter extends CustomPainter {
  _NotchedBarPainter({required this.bottomInset});

  final double bottomInset;

  static const _topRadius = 18.0;
  static const _notchRadius = 36.0;
  static const _notchDepth = 20.0;
  static const _notchSpread = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    final barHeight = size.height - bottomInset;
    final path = _buildBarPath(size.width, barHeight);

    // canvas.drawShadow(
    //   path,
    //   Colors.black.withValues(alpha: 0.18),
    //   8,
    //   false,
    // );

    canvas.drawPath(path, Paint()..color = _barColor);
  }

  Path _buildBarPath(double width, double height) {
    final centerX = width / 2;
    final path = Path();

    path.moveTo(0, _topRadius);
    path.quadraticBezierTo(0, 0, _topRadius, 0);
    path.lineTo(centerX - _notchRadius - _notchSpread, 0);

    // Cutout dips down into the bar; area above the curve stays empty.
    path.cubicTo(
      centerX - _notchRadius + 6,
      0,
      centerX - _notchRadius * 0.55,
      _notchDepth,
      centerX,
      _notchDepth,
    );
    path.cubicTo(
      centerX + _notchRadius * 0.55,
      _notchDepth,
      centerX + _notchRadius - 6,
      0,
      centerX + _notchRadius + _notchSpread,
      0,
    );

    path.lineTo(width - _topRadius, 0);
    path.quadraticBezierTo(width, 0, width, _topRadius);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant _NotchedBarPainter oldDelegate) {
    return oldDelegate.bottomInset != bottomInset;
  }
}
