import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/widgets/chat_widgets/user_chat.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mesajlar"),
      ),
      body: const UserChat(),
    );
  }
}
