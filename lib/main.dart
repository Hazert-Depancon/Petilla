import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/auth/auth_view/login_view/login_view.dart';
import 'package:petilla_app_project/constant/string_constant/shared_preferences_key_constants.dart';
import 'package:petilla_app_project/start/onboarding/onboarding.dart';
import 'package:petilla_app_project/start/select_app_view/select_app_view.dart';
import 'package:petilla_app_project/init/theme/light_theme/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await _init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool(SharedPreferencesKeyConstants.showHomeConstant) ?? false;

  runApp(
    Petilla(showHome: showHome),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Petilla extends StatelessWidget {
  const Petilla({Key? key, required this.showHome}) : super(key: key);
  final bool showHome;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      home: showHome
          ? FirebaseAuth.instance.currentUser != null
              ? const SelectAppView()
              : LoginView()
          : const Onboarding(),
    );
  }
}
