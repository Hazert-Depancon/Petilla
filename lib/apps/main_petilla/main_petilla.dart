import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/add_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/home_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/chat_select_view.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class MainPetilla extends StatefulWidget {
  const MainPetilla({Key? key}) : super(key: key);

  @override
  State<MainPetilla> createState() => _MainPetillaState();
}

class _MainPetillaState extends State<MainPetilla> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
    const PetillaHomeView(),
    // const FavoritesView(),
    const AddView(),
    const ChatSelectView(),
    // const DeclarationView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: pages[_selectedIndex],
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: LightThemeColors.white,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        _homeBottomNavigation(),
        // _favoritesBottomNavigation(),
        _addBottomNavigation(),
        _chatsBottomNavigation(),
        // _declarationBottomNavigation(),
      ],
    );
  }

  // BottomNavigationBarItem _declarationBottomNavigation() {
  //   return BottomNavigationBarItem(
  //     icon: _selectedIndex == 4 ? const Icon(Icons.border_all) : const Icon(Icons.border_all_outlined),
  //     label: "İlanlarım",
  //   );
  // }

  BottomNavigationBarItem _chatsBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 2 ? const Icon(Icons.chat_bubble) : const Icon(Icons.chat_bubble_outline),
      label: "Mesajlarım",
    );
  }

  BottomNavigationBarItem _addBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 1 ? const Icon(Icons.add_circle) : const Icon(Icons.add_circle_outline),
      label: "Evcil Hayvan Ekle",
    );
  }

  // BottomNavigationBarItem _favoritesBottomNavigation() {
  //   return BottomNavigationBarItem(
  //     icon: _selectedIndex == 1 ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
  //     label: "Favorilerim",
  //   );
  // }

  BottomNavigationBarItem _homeBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _homeIcon(),
      label: "Anasayfa",
    );
  }

  SvgPicture _homeIcon() {
    return SvgPicture.asset(
      _selectedIndex == 0 ? "assets/svg/home.svg" : "assets/svg/home_outline.svg",
      color: _selectedIndex == 0 ? LightThemeColors.miamiMarmalade : Colors.grey,
      height: 25,
    );
  }
}
