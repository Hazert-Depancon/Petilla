import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

class ChatService {
  static final ChatService _chatService = ChatService._internal();
  factory ChatService() {
    return _chatService;
  }
  ChatService._internal();

  void sendMessage(String message, TextEditingController controller, currentUserId, friendUserId, friendUserEmail,
      currentUserEmail, friendUserName, currentUserName) async {
    if (message.isEmpty) {
      return;
    } else {
      controller.clear();
      FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(currentUserId)
          .collection(AppFirestoreCollectionNames.messages)
          .doc(friendUserId)
          .collection(AppFirestoreCollectionNames.chatsCollection)
          .add({
        AppFirestoreFieldNames.senderIdField: currentUserId,
        AppFirestoreFieldNames.receiverIdField: friendUserId,
        AppFirestoreCollectionNames.messages: message,
        AppFirestoreFieldNames.dateField: DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection(AppFirestoreCollectionNames.usersCollection)
            .doc(currentUserId)
            .collection(AppFirestoreCollectionNames.messages)
            .doc(friendUserId)
            .set({
          AppFirestoreFieldNames.lastMsgField: message,
          AppFirestoreFieldNames.emailField: friendUserEmail,
          AppFirestoreFieldNames.nameField: friendUserName,
          AppFirestoreFieldNames.uidField: friendUserId,
        });
      });

      await FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(friendUserId)
          .collection(AppFirestoreCollectionNames.messages)
          .doc(currentUserId)
          .collection(AppFirestoreCollectionNames.chatsCollection)
          .add({
        AppFirestoreFieldNames.senderIdField: currentUserId,
        AppFirestoreFieldNames.receiverIdField: friendUserId,
        AppFirestoreCollectionNames.messages: message,
        AppFirestoreFieldNames.dateField: DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection(AppFirestoreCollectionNames.usersCollection)
            .doc(friendUserId)
            .collection(AppFirestoreCollectionNames.messages)
            .doc(currentUserId)
            .set({
          AppFirestoreFieldNames.lastMsgField: message,
          AppFirestoreFieldNames.uidField: currentUserId,
          AppFirestoreFieldNames.nameField: currentUserName,
          AppFirestoreFieldNames.emailField: currentUserEmail,
        });
      });
    }
  }
}
