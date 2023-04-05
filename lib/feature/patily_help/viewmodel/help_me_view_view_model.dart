// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/patily_help/service/patily_help_service.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';

part 'help_me_view_view_model.g.dart';

class HelpMeViewViewModel = _HelpMeViewViewModelBase with _$HelpMeViewViewModel;

abstract class _HelpMeViewViewModelBase with Store, BaseViewModel {
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
  Future<Position> getCurrentLocation() async {
    return await PatilyHelpService().getCurrentLocation();
  }

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
  Future<void> loadFirestore(HelpMeModel helpMeModel) async {
    await PatilyHelpService().loadFirestore(helpMeModel);
  }

  @action
  void callHelpMeHomeView() {
    Navigator.pop(viewModelContext);
    Navigator.pop(viewModelContext);
  }
}
