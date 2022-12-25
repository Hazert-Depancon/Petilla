import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

part 'feedback_view_view_model.g.dart';

// ignore: library_private_types_in_public_api
class FeedBackViewViewModel = _FeedBackViewViewModelBase with _$FeedBackViewViewModel;

abstract class _FeedBackViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  Future<void> onSubmitButton(
      TextEditingController titleController, TextEditingController descriptionController,) async {
    FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.feedBacks).add({
      AppFirestoreFieldNames.title: titleController.text.trim(),
      AppFirestoreFieldNames.descriptionField: descriptionController.text.trim(),
    });
  }
}
