import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petilla_app_project/view/main_view/add_view/add_view.dart';
import 'package:petilla_app_project/view/main_view/chat_view.dart';
import 'package:petilla_app_project/view/main_view/favorites_view.dart';
import 'package:petilla_app_project/view/main_view/home_view.dart';
import 'package:petilla_app_project/view/main_view/profile_view.dart';
import 'package:petilla_app_project/view/theme/light_theme.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const Petilla());
}

class Petilla extends StatefulWidget {
  const Petilla({Key? key}) : super(key: key);

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
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: _bottomNavigationBar(),
      ),
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
