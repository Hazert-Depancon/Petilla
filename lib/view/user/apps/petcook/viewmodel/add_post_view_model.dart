// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/components/dialogs/default_dialog.dart';
import 'package:petilla_app_project/view/user/apps/petcook/core/firebase/load_photo_to_firebase.dart';
import 'package:petilla_app_project/view/user/apps/petcook/core/models/post_model.dart';

part 'add_post_view_model.g.dart';

class AddPostViewModel = _AddPostViewModelBase with _$AddPostViewModel;

abstract class _AddPostViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  XFile? image;

  @observable
  File? imageFile;

  @observable
  bool isImageLoaded = false;

  @action
  Future<void> pickImageCamera() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      isImageLoaded = true;
      imageFile = File(image!.path);
    }
  }

  @action
  Future<void> pickImageGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    } else {
      isImageLoaded = true;
      imageFile = File(image!.path);
    }
  }

  @action
  Future<void> onSubmitButton(TextEditingController descriptionController) async {
    showDefaultLoadingDialog(false, viewModelContext);
    LoadPostToFirebase.instance
        .loadPhoto(
      PostModel(
        senderUserEmail: FirebaseAuth.instance.currentUser!.uid,
        senderUserName: FirebaseAuth.instance.currentUser!.displayName!,
        senderUserId: FirebaseAuth.instance.currentUser!.email!,
        postDowlandUrl: "",
        description: descriptionController.text.trim(),
      ),
      image!,
    )
        .whenComplete(() {
      Navigator.pop(viewModelContext);
      Navigator.pop(viewModelContext);
    });
  }
}
