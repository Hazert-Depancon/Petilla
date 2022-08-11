import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';

class PetillaMainBottomNavBar extends StatefulWidget {
  const PetillaMainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<PetillaMainBottomNavBar> createState() => _PetillaMainBottomNavBarState();
}

class _PetillaMainBottomNavBarState extends State<PetillaMainBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: LightThemeColors.white,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 0 ? "assets/svg/home.svg" : "assets/svg/home_outline.svg",
            color: _selectedIndex == 0 ? LightThemeColors.miamiMarmalade : Colors.grey,
            height: 25,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1 ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2 ? const Icon(Icons.add_circle) : const Icon(Icons.add_circle_outline),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 3 ? const Icon(Icons.chat_bubble) : const Icon(Icons.chat_bubble_outline),
          label: "Chats",
        ),
      ],
    );
  }
}
