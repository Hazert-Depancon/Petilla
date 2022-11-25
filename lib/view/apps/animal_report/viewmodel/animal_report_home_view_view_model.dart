// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

part 'animal_report_home_view_view_model.g.dart';

class AnimalReportHomeViewModel = _AnimalReportHomeViewModelBase with _$AnimalReportHomeViewModel;

abstract class _AnimalReportHomeViewModelBase with Store, BaseViewModel {
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
  Future<void> loadFirestore(dowlandLink, descriptionController, phoneNumberController, swichValue, lat, long) async {
    FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.reportAnimalCollection).add({
      AppFirestoreFieldNames.imagePathField: dowlandLink == "" ? null : dowlandLink,
      AppFirestoreFieldNames.descriptionField: descriptionController.text,
      AppFirestoreFieldNames.phoneNumberField: phoneNumberController.text,
      AppFirestoreFieldNames.adoptField: swichValue,
      AppFirestoreFieldNames.lat: lat,
      AppFirestoreFieldNames.long: long,
    });
  }

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
}
