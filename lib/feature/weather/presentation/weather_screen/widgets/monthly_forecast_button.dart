import 'package:flutter/material.dart';

class MonthlyForecastButton extends StatelessWidget {
  const MonthlyForecastButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF061B35).withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Прогноз на месяц',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
    );
  }
}
