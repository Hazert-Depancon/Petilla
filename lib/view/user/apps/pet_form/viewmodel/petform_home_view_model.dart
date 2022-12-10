import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/init/google_ads/ads_state.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/view/group_template_view.dart';

part 'petform_home_view_model.g.dart';

class PetformHomeViewViewModel = PetformHomeViewViewModelBase with _$PetformHomeViewViewModel;

abstract class PetformHomeViewViewModelBase with Store, BaseViewModel {
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
  void callGroupChatView(
    String title,
    String assetName,
    String collectionId,
    String docId,
    String pageTitle,
    context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupChat(
          collectionId: collectionId,
          docId: docId,
          pageTitle: pageTitle,
        ),
      ),
    );
  }
}
