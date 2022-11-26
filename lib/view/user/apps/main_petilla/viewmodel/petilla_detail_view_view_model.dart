// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/utility/widget_utility/fav_button_service.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/in_chat_view.dart';

part 'petilla_detail_view_view_model.g.dart';

class DetailViewViewModel = _DetailViewViewModelBase with _$DetailViewViewModel;

abstract class _DetailViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  bool? isFav;

  @action
  favButton(docId) async {
    isFav = await FavButtonService().favButton(docId);
  }

  @action
  addFav(docId) async {
    isFav = await FavButtonService().addFav(docId);
  }

  @action
  removeFav(docId) async {
    isFav = await FavButtonService().removeFav(docId);
  }

  @action
  changeFav(docId) async {
    FavButtonService().changeFav(docId, isFav);
  }

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
}
