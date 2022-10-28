import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/add_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_home_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_insert_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/chat_select_view.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/utility/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
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
    const ChatSelectView(),
    const AddView(),
    const PetillaInsertView(),
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
        _chatsBottomNavigation(),
        _addBottomNavigation(),
        _insertBottomNavigation(),
      ],
    );
  }

  BottomNavigationBarItem _chatsBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 1 ? const Icon(AppIcons.chatIcon) : const Icon(AppIcons.chatOutlinedIcon),
      label: Localization.myMessages,
    );
  }

  BottomNavigationBarItem _addBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 2 ? const Icon(AppIcons.addCircleIcon) : const Icon(AppIcons.addCircleOutlinedIcon),
      label: Localization.addAPet,
    );
  }

  BottomNavigationBarItem _homeBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _homeIcon(),
      label: Localization.homePage,
    );
  }

  BottomNavigationBarItem _insertBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 3 ? const Icon(AppIcons.insertOutlineIcon) : const Icon(AppIcons.insertOutlineIcon),
      label: Localization.myMessages,
    );
  }

  SvgPicture _homeIcon() {
    return SvgPicture.asset(
      _selectedIndex == 0 ? svgBuildConstant("home") : svgBuildConstant("home_outline"),
      color: _selectedIndex == 0 ? LightThemeColors.miamiMarmalade : LightThemeColors.grey,
      height: 25,
    );
  }
}
