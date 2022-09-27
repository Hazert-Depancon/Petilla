import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChat extends StatelessWidget {
  const UserChat({Key? key, required this.onTap, required this.name}) : super(key: key);

  final VoidCallback onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
