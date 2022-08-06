import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petilla_app_project/view/main_view/add_view/add_view.dart';
import 'package:petilla_app_project/view/main_view/chats/chat_view.dart';
import 'package:petilla_app_project/view/main_view/favorites_view.dart';
import 'package:petilla_app_project/view/main_view/home_view.dart';
import 'package:petilla_app_project/view/main_view/profile_view.dart';
import 'package:petilla_app_project/view/onboarding/onboarding_one.dart';
import 'package:petilla_app_project/view/theme/light_theme.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(
    DevicePreview(
      builder: (context) => Petilla(showHome: showHome),
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
    ),

    // Petilla(showHome: showHome),
  );
}

class Petilla extends StatefulWidget {
  const Petilla({Key? key, required this.showHome}) : super(key: key);
  final bool showHome;

  @override
  State<Petilla> createState() => _PetillaState();
}

class _PetillaState extends State<Petilla> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const HomeView(),
    const FavoritesView(),
    const AddView(),
    const ChatView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petilla',
      theme: LightTheme().theme,
      // home: const Onboarding(),
      home: widget.showHome
          ? Scaffold(
              body: pages[_selectedIndex],
              bottomNavigationBar: _bottomNavigationBar(),
            )
          : const Onboarding(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: LightThemeColors.miamiMarmalade,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Add"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
      ],
    );
  }
}
