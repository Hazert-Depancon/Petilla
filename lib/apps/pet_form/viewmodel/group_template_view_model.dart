import 'package:firebase_auth/firebase_auth.dart';
import 'package:petilla_app_project/apps/pet_form/service/group_message_service.dart';

class GroupTemplateViewModel {
  getCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      return user;
    }
  }

  void onSendButton(msg, docId, collectionId) {
    GroupMessageCrudService().sendMessage(msg, docId, collectionId);
  }
}
