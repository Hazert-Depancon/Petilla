// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/patily_help/service/patily_help_service.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';
import 'package:patily/feature/patily_sahiplen/view/in_chat_view.dart';

part 'help_me_detail_view_view_model.g.dart';

class HelpMeDetailViewViewModel = _HelpMeDetailViewViewModelBase
    with _$HelpMeDetailViewViewModel;

abstract class _HelpMeDetailViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
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

  @action
  Future<void> showInMap(HelpMeModel helpMeModel) async {
    PatilyHelpService().showInMap(helpMeModel);
  }
}
