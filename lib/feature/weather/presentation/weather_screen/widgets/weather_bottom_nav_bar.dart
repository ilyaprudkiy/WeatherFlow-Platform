import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

const _barColor = Color(0xB33D5873);
const _selectedBlue = AppColors.primary;
const _inactiveBlue = AppColors.bottomNavInactive;

class WeatherBottomNavBar extends StatelessWidget {
  const WeatherBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

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
                        selectedIndex: selectedIndex,
                        icon: Icons.home_outlined,
                        selectedIcon: Icons.home_rounded,
                        onTap: onSelected,
                      ),
                      _NavIconButton(
                        index: 1,
                        selectedIndex: selectedIndex,
                        icon: Icons.search_rounded,
                        selectedIcon: Icons.search_rounded,
                        onTap: onSelected,
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
                        selectedIndex: selectedIndex,
                        icon: Icons.bookmark_outline_rounded,
                        selectedIcon: Icons.bookmark_rounded,
                        onTap: onSelected,
                      ),
                      _NavIconButton(
                        index: 3,
                        selectedIndex: selectedIndex,
                        icon: Icons.insights_outlined,
                        selectedIcon: Icons.insights_rounded,
                        onTap: onSelected,
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
    canvas.drawPath(path, Paint()..color = _barColor);
  }

  Path _buildBarPath(double width, double height) {
    final centerX = width / 2;
    final path = Path();

    path.moveTo(0, _topRadius);
    path.quadraticBezierTo(0, 0, _topRadius, 0);
    path.lineTo(centerX - _notchRadius - _notchSpread, 0);

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
