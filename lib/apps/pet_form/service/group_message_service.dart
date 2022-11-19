import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

class GroupMessageCrudService {
  void sendMessage(msg, docId, collectionId) {
    final firestore = FirebaseFirestore.instance;
    if (msg.text.isNotEmpty) {
      firestore.collection(AppFirestoreCollectionNames.messages).doc(docId).collection(collectionId).doc().set({
        AppFirestoreFieldNames.msgField: msg.text.trim(),
        AppFirestoreFieldNames.userField: FirebaseAuth.instance.currentUser!.displayName,
        AppFirestoreFieldNames.timeField: DateTime.now(),
      });
      msg.clear();
    }
  }
}
