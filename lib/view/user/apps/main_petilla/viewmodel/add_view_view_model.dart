// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/add_view_two.dart';

part 'add_view_view_model.g.dart';

class AddViewViewModel = _AddViewViewModelBase with _$AddViewViewModel;

abstract class _AddViewViewModelBase with Store, BaseViewModel {
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

  @action
  Future<void> pickImageCamera() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      imageFile = File(image!.path);
    }
  }

  @action
  Future<void> pickImageGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    } else {
      imageFile = File(image!.path);
    }
  }

  @action
  void callAddViewTwo(name, description, val, image, context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddViewTwo(
          name: name.text,
          description: description.text,
          radioValue: val as int,
          image: image!,
        ),
      ),
    );
  }
}
