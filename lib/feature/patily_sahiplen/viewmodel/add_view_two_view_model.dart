// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/widgets/dialogs/default_dialog.dart';
import 'package:patily/product/init/google_ads/ads_state.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/patily_sahiplen/service/firebase_crud/crud_service.dart';
import 'package:patily/product/models/patily_sahiplen/pet_model.dart';
import 'package:patily/feature/patily_sahiplen/view/patily_sahiplen.dart';

part 'add_view_two_view_model.g.dart';

class AddViewTwoViewModel = _AddViewTwoViewModelBase with _$AddViewTwoViewModel;

abstract class _AddViewTwoViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

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
  onSubmitButton(
    context,
    image,
    imageUrl,
    genderSelectedValue,
    name,
    description,
    ageRangeSelectedValue,
    secilenIl,
    secilenIlce,
    type,
    radioValue,
    petSelectedValue,
  ) {
    showDefaultLoadingDialog(false, context);
    CrudService().createPet(
      image,
      PetModel(
        currentUserName: FirebaseAuth.instance.currentUser!.displayName!,
        currentUid: FirebaseAuth.instance.currentUser!.uid,
        currentEmail: FirebaseAuth.instance.currentUser!.email.toString(),
        gender: genderSelectedValue ?? LocaleKeys.error,
        name: name,
        description: description,
        imagePath: imageUrl,
        ageRange: ageRangeSelectedValue ?? LocaleKeys.error,
        city: secilenIl,
        ilce: secilenIlce,
        petBreed: type,
        price: radioValue == 1 ? "0" : "",
        petType: petSelectedValue ?? LocaleKeys.error,
      ),
      FirebaseCollectionEnum.pets.toString(),
      context,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainPatilySahiplen()),
      (route) => false,
    );
    return true;
  }
}
