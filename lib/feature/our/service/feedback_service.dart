import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/constants/string_constant/project_firestore_collection_names.dart';

class FeedBackService {
  Future<void> onSubmitButton(
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) async {
    FirebaseFirestore.instance
        .collection(AppFirestoreCollectionNames.feedBacks)
        .add({
      AppFirestoreFieldNames.title: titleController.text.trim(),
      AppFirestoreFieldNames.descriptionField:
          descriptionController.text.trim(),
    });
  }
}
