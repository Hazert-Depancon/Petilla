import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/feature/patily_form/view/add_question_view.dart';

part 'patily_form_home_view_model.g.dart';

class PatilyFormHomeViewViewModel = PatilyFormHomeViewViewModelBase
    with _$PatilyFormHomeViewViewModel;

abstract class PatilyFormHomeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  CollectionReference<Object?> stream() {
    return FirebaseCollectionEnum.patilyForm.reference;
  }

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
