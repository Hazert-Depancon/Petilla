import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';

class ChatService {
  static final ChatService _compressUtils = ChatService._internal();
  factory ChatService() {
    return _compressUtils;
  }
  ChatService._internal();

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
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(currentUserId)
          .collection(AppFirestoreCollectionNames.messagesCollection)
          .doc(friendUserId)
          .collection(AppFirestoreCollectionNames.chatsCollection)
          .add({
        AppFirestoreFieldNames.senderIdField: currentUserId,
        AppFirestoreFieldNames.receiverIdField: friendUserId,
        AppFirestoreFieldNames.messageField: message,
        AppFirestoreFieldNames.dateField: DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection(AppFirestoreCollectionNames.usersCollection)
            .doc(currentUserId)
            .collection(AppFirestoreCollectionNames.messagesCollection)
            .doc(friendUserId)
            .set({
          AppFirestoreFieldNames.lastMsgField: message,
          AppFirestoreFieldNames.emailField: friendUserEmail,
          AppFirestoreFieldNames.uidField: friendUserId,
        });
      });

      await FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(friendUserId)
          .collection(AppFirestoreCollectionNames.messagesCollection)
          .doc(currentUserId)
          .collection(AppFirestoreCollectionNames.chatsCollection)
          .add({
        AppFirestoreFieldNames.senderIdField: currentUserId,
        AppFirestoreFieldNames.receiverIdField: friendUserId,
        AppFirestoreFieldNames.messageField: message,
        AppFirestoreFieldNames.dateField: DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection(AppFirestoreCollectionNames.usersCollection)
            .doc(friendUserId)
            .collection(AppFirestoreCollectionNames.messagesCollection)
            .doc(currentUserId)
            .set({
          AppFirestoreFieldNames.lastMsgField: message,
          AppFirestoreFieldNames.uidField: currentUserId,
          AppFirestoreFieldNames.emailField: currentUserEmail,
        });
      });
    }
  }
}
