import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/general/general_widgets/single_message.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class CatGroupChat extends StatefulWidget {
  const CatGroupChat({Key? key}) : super(key: key);

  @override
  State<CatGroupChat> createState() => _CatGroupChatState();
}

class _CatGroupChatState extends State<CatGroupChat> {
  final auth = FirebaseAuth.instance;
  TextEditingController msg = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kedi Grubu'),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: ShowMessages()),
          Padding(
            padding: ProjectPaddings.horizontalMainPadding,
            child: Row(
              children: [
                Expanded(child: _textField(msg)),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _onSendButton() {
    if (msg.text.isNotEmpty) {
      _firestore.collection("messages").doc("cat_chat").collection("cat_messages").doc().set({
        "msg": msg.text.trim(),
        "user": loginUser!.email.toString(),
        "time": DateTime.now(),
      });
      msg.clear();
    }
  }

  TextField _textField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Bir mesaj yaz...',
        suffixIcon: _sendButton(controller),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
        ),
      ),
    );
  }

  _sendButton(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 45,
        width: 45,
        child: CircleAvatar(
          backgroundColor: LightThemeColors.miamiMarmalade,
          foregroundColor: LightThemeColors.white,
          child: IconButton(
            onPressed: _onSendButton,
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}

class ShowMessages extends StatelessWidget {
  const ShowMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .doc("cat_chat")
          .collection("cat_messages")
          .orderBy("time")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot querySnapshot = snapshot.data!.docs[index];
              return Column(
                crossAxisAlignment:
                    loginUser!.email == querySnapshot["user"] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(querySnapshot["user"]),
                  ),
                  SingleMessage(
                      message: querySnapshot["msg"], isMe: querySnapshot["user"] == loginUser!.email.toString()),
                ],
              );
            },
          );
        }
        return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
      },
    );
  }
}
