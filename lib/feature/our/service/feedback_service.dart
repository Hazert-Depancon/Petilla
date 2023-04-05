import 'package:flutter/material.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';

class FeedBackService {
  Future<void> onSubmitButton(
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) async {
    FirebaseCollectionEnum.feedBacks.reference.add({
      AppFirestoreFieldNames.title: titleController.text.trim(),
      AppFirestoreFieldNames.descriptionField:
          descriptionController.text.trim(),
    });
  }
}
