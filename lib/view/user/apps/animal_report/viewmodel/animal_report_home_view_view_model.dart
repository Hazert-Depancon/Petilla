// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/init/google_ads/ads_state.dart';

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

  @observable
  InterstitialAd? interstitialAd;

  @action
  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdmobManager.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => interstitialAd = null,
      ),
    );
  }

  @action
  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

  @action
  Future<void> loadFirestore(
    dowlandLink,
    descriptionController,
    phoneNumberController,
    swichValue,
    lat,
    long,
    isDamaged,
  ) async {
    await FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.reportAnimalCollection).add({
      AppFirestoreFieldNames.imagePathField: dowlandLink == "" ? null : dowlandLink,
      AppFirestoreFieldNames.descriptionField: descriptionController.text,
      AppFirestoreFieldNames.phoneNumberField: phoneNumberController.text,
      AppFirestoreFieldNames.lat: lat,
      AppFirestoreFieldNames.long: long,
      AppFirestoreFieldNames.currentEmailField: FirebaseAuth.instance.currentUser!.email,
      AppFirestoreFieldNames.currentNameField: FirebaseAuth.instance.currentUser!.displayName,
      AppFirestoreFieldNames.currentUidField: FirebaseAuth.instance.currentUser!.uid,
      AppFirestoreFieldNames.isDamaged: isDamaged,
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
