// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/service/group_message_service.dart';

part 'group_template_view_model.g.dart';

class GroupTemplateViewModel = _GroupTemplateViewModelBase with _$GroupTemplateViewModel;

abstract class _GroupTemplateViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  getCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      return user;
    }
  }

  @action
  void onSendButton(msg, docId, collectionId) {
    GroupMessageCrudService().sendMessage(msg, docId, collectionId);
  }
}
