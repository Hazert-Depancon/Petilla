import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/view/in_chat_view.dart';

class PetillaDetailVievModel {
  void callChatPage(context, currentUserName, currentUserId, currentUserEmail) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          friendUserName: currentUserName,
          currentUserEmail: FirebaseAuth.instance.currentUser!.email!,
          currentUserId: FirebaseAuth.instance.currentUser!.uid,
          friendUserId: currentUserId,
          friendUserEmail: currentUserEmail,
          currentUserName: FirebaseAuth.instance.currentUser!.displayName!,
        ),
      ),
    );
  }
}
