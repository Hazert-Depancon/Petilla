import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/apps/pet_form/view/group_template_view.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';

part 'petform_home_view_model.g.dart';

class PetformHomeViewViewModel = PetformHomeViewViewModelBase with _$PetformHomeViewViewModel;

abstract class PetformHomeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callGroupChatView(
    String title,
    String assetName,
    String collectionId,
    String docId,
    String pageTitle,
    context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupChat(
          collectionId: collectionId,
          docId: docId,
          pageTitle: pageTitle,
        ),
      ),
    );
  }
}
