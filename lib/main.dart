import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/auth/auth_view/login_view.dart';
import 'package:petilla_app_project/start/onboarding/onboarding_one.dart';
import 'package:petilla_app_project/theme/light_theme.dart';
import 'package:petilla_app_project/start/select_app_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FirebaseW
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(
    // DevicePreview(
    //   builder: (context) => Petilla(showHome: showHome),
    //   enabled: true,
    //   tools: const [
    //     ...DevicePreview.defaultTools,
    //   ],
    // ),

    Petilla(showHome: showHome),
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
      debugShowCheckedModeBanner: false,
      title: 'Petilla',
      theme: LightTheme().theme,
      home: widget.showHome
          ? FirebaseAuth.instance.currentUser != null
              ? const SelectAppView()
              : const LoginView()
          : const Onboarding(),
    );
  }
}
