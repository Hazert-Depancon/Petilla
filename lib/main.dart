import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/auth/onboard/view/onboarding.dart';
import 'package:petilla_app_project/auth/view/login_view.dart';
import 'package:petilla_app_project/core/constants/app/app_constants.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:petilla_app_project/core/init/cache/locale_manager.dart';
import 'package:petilla_app_project/core/init/lang/language_manager.dart';
import 'package:petilla_app_project/core/init/router/app_router.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme.dart';
import 'package:petilla_app_project/start/view/select_app_view.dart';

Future<void> main() async {
  await _init();
  _initSystemUi();

  final showHome = LocaleManager.instance.getBoolValue(SharedKeys.SHOWHOME);

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.LANG_ASSET_PATH,
      child: Petilla(showHome: showHome),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocaleManager.preferencesInit();
  await Firebase.initializeApp();
}

void _initSystemUi() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
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
  void initState() {
    super.initState();
    Control(showhome: widget.showHome);
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
    );
  }
}

class Control extends StatelessWidget {
  const Control({super.key, required this.showhome});
  final bool showhome;

  @override
  Widget build(BuildContext context) {
    return showhome
        ? FirebaseAuth.instance.currentUser != null
            ? const SelectAppView()
            : LoginView()
        : const Onboarding();
  }
}
