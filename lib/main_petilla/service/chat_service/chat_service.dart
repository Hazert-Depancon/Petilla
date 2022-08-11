import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatService {
  void sendMessage(
    String message,
    TextEditingController controller,
    currentUserId,
    friendUserId,
    friendUserEmail,
    currentUserEmail,
  ) async {
    if (message.isEmpty) {
      return;
    } else {
      controller.clear();
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("messages")
          .doc(friendUserId)
          .collection("chats")
          .add({
        "senderId": currentUserId,
        "receiverId": friendUserId,
        "message": message,
        "type": "text",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance.collection("users").doc(currentUserId).collection("messages").doc(friendUserId).set({
          "last_msg": message,
          "email": friendUserEmail,
          "uid": friendUserId,
        });
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(friendUserId)
          .collection("messages")
          .doc(currentUserId)
          .collection("chats")
          .add({
        "senderId": currentUserId,
        "receiverId": friendUserId,
        "message": message,
        "type": "text",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance.collection("users").doc(friendUserId).collection("messages").doc(currentUserId).set({
          "last_msg": message,
          "uid": currentUserId,
          "email": currentUserEmail,
        });
      });
    }
  }
}
