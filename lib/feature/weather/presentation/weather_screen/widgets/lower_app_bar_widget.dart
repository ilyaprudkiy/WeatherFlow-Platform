import 'package:flutter/material.dart';

class LowerAppBarWidget extends StatelessWidget {
  const LowerAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: const Color(0xFF3D5873).withValues(alpha: 0.65),
        fixedColor: const Color(0xFF3D5873).withValues(alpha: 0.65),
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.calendar_month,
              color: Colors.blueAccent,
            ),
            label: 'hours',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
              color: Colors.blueAccent,
            ),
            label: 'today',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_outlined,
              color: Colors.blueAccent,
            ),
            label: 'Days',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
            label: 'Search',
          )
        ]);
  }
}