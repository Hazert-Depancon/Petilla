// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_view_model.dart';
import 'package:patily/view/user/apps/help_me/core/models/help_me_model.dart';
import 'package:patily/view/user/apps/patilla/view/in_chat_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    String googleURL =
        "https://www.google.com/maps/search/?api=1&query=${helpMeModel.lat},${helpMeModel.long}";
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw "ERROR";
  }
}
