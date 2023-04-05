import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:patily/product/constants/app/app_constants.dart';
import 'package:patily/product/constants/enums/locale_keys_enum.dart';
import 'package:patily/product/init/cache/locale_manager.dart';
import 'package:patily/product/init/lang/language_manager.dart';
import 'package:patily/product/init/theme/light_theme/light_theme.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/feature/onboard/view/onboard_view.dart';
import 'package:patily/feature/auth/view/login_view.dart';
import 'package:patily/feature/select_app/view/select_app_view.dart';

Future<void> main() async {
  await _init();
  _initSystemUi();

  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  final showHome = LocaleManager.instance.getBoolValue(SharedKeys.SHOWHOME);

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.LANG_ASSET_PATH,
      child: Patily(
        showHome: showHome,
        status: status,
      ),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await EasyLocalization.ensureInitialized();
  await LocaleManager.preferencesInit();
  await Firebase.initializeApp();
}

void _initSystemUi() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: LightThemeColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class Patily extends StatelessWidget {
  const Patily({Key? key, required this.showHome, this.status})
      : super(key: key);
  final bool showHome;
  final TrackingStatus? status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case TrackingStatus.authorized:
        break;
      case TrackingStatus.denied:
        break;
      case TrackingStatus.notDetermined:
        break;
      case TrackingStatus.notSupported:
        break;
      case TrackingStatus.restricted:
        break;
      default:
        break;
    }
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      title: "Patily",
      home: showHome
          ? FirebaseAuth.instance.currentUser != null
              ? const SelectAppView()
              : LoginView()
          : const Onboarding(),
    );
  }
}
