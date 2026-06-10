import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 450,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFFDFDFB),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.local_offer_outlined, color: Colors.grey),
                  Icon(Icons.emoji_events_outlined, color: Colors.grey),
                  SizedBox(width: 70),
                  Icon(Icons.music_note_outlined, color: Colors.grey),
                  Icon(Icons.person_outline, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
