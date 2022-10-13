import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/auth/auth_view/login_view.dart';
import 'package:petilla_app_project/start/onboarding/onboarding.dart';
import 'package:petilla_app_project/start/select_app_view.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;

  runApp(
    // DevicePreview(
    //   builder: (context) => Petilla(showHome: showHome),
    //   enabled: true,
    //   tools: const [
    //     ...DevicePreview.defaultTools,
    //   ],
    // ),

    EasyLocalization(
      supportedLocales: const [
        Locale("tr", "TR"),
      ],
      path: "assets/jsons/localization",
      saveLocale: true,
      fallbackLocale: const Locale("tr", "TR"),
      child: Petilla(showHome: showHome),
    ),
  );
}

class Petilla extends StatefulWidget {
  const Petilla({Key? key, required this.showHome}) : super(key: key);
  final bool showHome;

  @override
  State<Petilla> createState() => _PetillaState();
}

class _PetillaState extends State<Petilla> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: Localization.appName,
      theme: LightTheme().theme,
      home: widget.showHome
          ? FirebaseAuth.instance.currentUser != null
              ? const SelectAppView()
              : const LoginView()
          : const Onboarding(),
    );
  }
}
