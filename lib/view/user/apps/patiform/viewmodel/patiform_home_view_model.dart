import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/view/user/apps/patiform/view/add_question_view.dart';

part 'patiform_home_view_model.g.dart';

class PatiformHomeViewViewModel = PatiformHomeViewViewModelBase
    with _$PatiformHomeViewViewModel;

abstract class PatiformHomeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  CollectionReference<Map<String, dynamic>> stream = FirebaseFirestore.instance
      .collection(AppFirestoreCollectionNames.patiform);

  @action
  void callAddQuestionView() {
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => const AddQuestionView(),
      ),
    );
  }
}
