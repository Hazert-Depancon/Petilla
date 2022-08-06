import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petilla_app_project/view/main_view/chats/in_chat_view.dart';

class UserChat extends StatelessWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InChatView(
              userName: "Name",
            ),
          ),
        );
      },
      child: Container(
        width: Get.width,
        height: 125,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red.withOpacity(0.8),
              child: const Text("U", style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text("Son mesajınız.", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
