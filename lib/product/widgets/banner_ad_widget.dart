import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:patily/product/init/google_ads/ads_state.dart';

class AdWidgetBanner extends StatefulWidget {
  const AdWidgetBanner({super.key});

  @override
  State<AdWidgetBanner> createState() => _AdWidgetBannerState();
}

class _AdWidgetBannerState extends State<AdWidgetBanner> {
  BannerAd? _banner;

  void _createBannerAd() {
    _banner = AdmobManager().createBannerAd();
  }

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return _banner == null
        ? Container()
        : Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: 52,
            child: AdWidget(ad: _banner!),
          );
  }
}
