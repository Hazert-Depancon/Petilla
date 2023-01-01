// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/view/user/apps/help_me/core/models/help_me_model.dart';

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
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("ERROR");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("ERROR");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("ERROR");
    }
    return await Geolocator.getCurrentPosition();
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
    FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.animalHelp).add({
      AppFirestoreFieldNames.title: helpMeModel.title.trim(),
      AppFirestoreFieldNames.descriptionField: helpMeModel.description.trim(),
      AppFirestoreFieldNames.isFoodHelp: helpMeModel.isFoodHelp,
      AppFirestoreFieldNames.isVetHelp: helpMeModel.isVetHelp,
      AppFirestoreFieldNames.lat: helpMeModel.lat,
      AppFirestoreFieldNames.long: helpMeModel.long,
      AppFirestoreFieldNames.imagePathField: helpMeModel.imageDowlandUrl,
    });
  }

  @action
  void callHelpMeHomeView() {
    Navigator.pop(viewModelContext);
    Navigator.pop(viewModelContext);
  }
}
