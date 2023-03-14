import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

part 'petform_home_view_model.g.dart';

class PetformHomeViewViewModel = PetformHomeViewViewModelBase
    with _$PetformHomeViewViewModel;

abstract class PetformHomeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  CollectionReference<Map<String, dynamic>> stream = FirebaseFirestore.instance
      .collection(AppFirestoreCollectionNames.petform);
}
