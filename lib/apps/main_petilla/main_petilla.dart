import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/add_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/home_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/chat_select_view.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
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
    const AddView(),
    const ChatSelectView(),
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
        _addBottomNavigation(),
        _chatsBottomNavigation(),
      ],
    );
  }

  BottomNavigationBarItem _chatsBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 2 ? const Icon(AppIcons.chatIcon) : const Icon(AppIcons.chatOutlinedIcon),
      label: "my_messages".tr(),
    );
  }

  BottomNavigationBarItem _addBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _selectedIndex == 1 ? const Icon(AppIcons.addCircleIcon) : const Icon(AppIcons.addCircleOutlinedIcon),
      label: "add_a_pet".tr(),
    );
  }

  BottomNavigationBarItem _homeBottomNavigation() {
    return BottomNavigationBarItem(
      icon: _homeIcon(),
      label: "home_page".tr(),
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
