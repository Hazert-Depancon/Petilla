import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChat extends StatelessWidget {
  const UserChat({Key? key, required this.onTap, required this.name}) : super(key: key);

  final VoidCallback onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    int random = Random().nextInt(12);

    List<Color> randomColors = [
      const Color(0xFFba9f95),
      const Color(0xFF9280d0),
      const Color(0xFFb1b987),
      const Color(0xFFC2D3F2),
      const Color(0xFF6E85B7),
      const Color(0xFFFFD9C0),
      const Color(0xFFFFF89A),
      const Color(0xFFC0A080),
      const Color(0xFFBF8B67),
      const Color(0xFFA267AC),
      const Color(0xFFB983FF),
      const Color(0xFFFF7878),
    ];

    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 35,
              backgroundColor: randomColors[random],
              child: Text(name[0], style: const TextStyle(fontSize: 40, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  // Text(lastMessage, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
