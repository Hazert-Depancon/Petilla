import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobManager {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6393554220663084/8851212254";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6393554220663084/1515647712";
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

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
  );
}
