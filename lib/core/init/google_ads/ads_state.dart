import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobManager {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    }
    return null;
  }

  BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdmobManager.bannerAdUnitId!,
      listener: AdmobManager.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  // createInterstitialAd() {
  //   return InterstitialAd.load(
  //     adUnitId: interstitialAdUnitId!,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) =>
  //       onAdFailedToLoad: (ad, error) {},
  //     ),
  //   );
  // }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
  );
}
