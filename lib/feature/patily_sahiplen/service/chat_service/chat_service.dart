import 'package:flutter/cupertino.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';

class ChatService {
  static final ChatService _chatService = ChatService._internal();
  factory ChatService() {
    return _chatService;
  }
  ChatService._internal();

  void sendMessage(
      String message,
      TextEditingController controller,
      currentUserId,
      friendUserId,
      friendUserEmail,
      currentUserEmail,
      friendUserName,
      currentUserName) async {
    if (message.isEmpty) {
      return;
    } else {
      controller.clear();
      FirebaseCollectionEnum.users.reference
          .doc(currentUserId)
          .collection(FirebaseCollectionEnum.messages.toString())
          .doc(friendUserId)
          .collection(FirebaseCollectionEnum.chats.toString())
          .add({
        AppFirestoreFieldNames.senderIdField: currentUserId,
        AppFirestoreFieldNames.receiverIdField: friendUserId,
        AppFirestoreFieldNames.messagesField: message,
        AppFirestoreFieldNames.dateField: DateTime.now(),
      }).then((value) {
        FirebaseCollectionEnum.users.reference
            .doc(currentUserId)
            .collection(FirebaseCollectionEnum.messages.toString())
            .doc(friendUserId)
            .set({
          AppFirestoreFieldNames.lastMsgField: message,
          AppFirestoreFieldNames.emailField: friendUserEmail,
          AppFirestoreFieldNames.nameField: friendUserName,
          AppFirestoreFieldNames.uidField: friendUserId,
        });
      });

      await FirebaseCollectionEnum.users.reference
          .doc(friendUserId)
          .collection(FirebaseCollectionEnum.messages.toString())
          .doc(currentUserId)
          .collection(FirebaseCollectionEnum.chats.toString())
          .add({
        AppFirestoreFieldNames.senderIdField: currentUserId,
        AppFirestoreFieldNames.receiverIdField: friendUserId,
        AppFirestoreFieldNames.messagesField: message,
        AppFirestoreFieldNames.dateField: DateTime.now(),
      }).then((value) {
        FirebaseCollectionEnum.users.reference
            .doc(friendUserId)
            .collection(FirebaseCollectionEnum.messages.toString())
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
