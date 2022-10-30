import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';

class GroupTemplateViewModel {
  getCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      return user;
    }
  }

  void onSendButton(msg, docId, collectionId) {
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
