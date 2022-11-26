// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/in_chat_view.dart';

part 'chat_select_view_model.g.dart';

class ChatSelectViewModel = _ChatSelectViewModelBase with _$ChatSelectViewModel;

abstract class _ChatSelectViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callInChat(
    String friendEmail,
    String friendUid,
    String currentEmail,
    String currentUid,
    String friendUserName,
    String currentUserName,
    context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          friendUserName: friendUserName,
          currentUserId: currentUid,
          currentUserEmail: currentEmail,
          friendUserId: friendUid,
          friendUserEmail: friendEmail,
          currentUserName: currentUserName,
        ),
      ),
    );
  }

  @action
  void callChat(snapshot, index, context) {
    return callInChat(
      snapshot.data!.docs[index][AppFirestoreFieldNames.emailField],
      snapshot.data!.docs[index][AppFirestoreFieldNames.uidField],
      FirebaseAuth.instance.currentUser!.email.toString(),
      FirebaseAuth.instance.currentUser!.uid,
      snapshot.data!.docs[index][AppFirestoreFieldNames.nameField],
      FirebaseAuth.instance.currentUser!.displayName!,
      context,
    );
  }
}
