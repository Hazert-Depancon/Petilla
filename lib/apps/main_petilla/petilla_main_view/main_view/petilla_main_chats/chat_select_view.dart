import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/in_chat_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/widgets/chat_widgets/user_chat.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class ChatSelectView extends StatefulWidget {
  const ChatSelectView({Key? key}) : super(key: key);

  @override
  State<ChatSelectView> createState() => _ChatSelectViewState();
}

class _ChatSelectViewState extends State<ChatSelectView> {
  void callInChat(String friendEmail, String friendUid, String currentEmail, String currentUid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          currentUserId: currentUid,
          currentUserEmail: currentEmail,
          friendUserId: friendUid,
          friendUserEmail: friendEmail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("messages")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    const Text("Henüz kimseyle mesajlaşmadınız", style: TextStyle(fontSize: 20)),
                    Center(child: Lottie.network(ProjectLottieUrls.emptyLottie)),
                  ],
                ),
              );
            } else {
              ListView.builder(
                itemBuilder: (context, index) {
                  return UserChat(
                    name: snapshot.data!.docs[index]["email"],
                    onTap: () {
                      callInChat(
                        snapshot.data!.docs[index]["email"],
                        snapshot.data!.docs[index]["uid"],
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        FirebaseAuth.instance.currentUser!.uid,
                      );
                    },
                  );
                },
              );
            }
          }
          if (snapshot.hasError) {
            return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
          }
          return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
        },
      ),
    );
  }
}
