import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/feature/patily_sahiplen/view/add_view.dart';
import 'package:patily/feature/patily_sahiplen/view/chat_select_view.dart';
import 'package:patily/feature/patily_sahiplen/view/favorites_view.dart';
import 'package:patily/feature/patily_sahiplen/view/patily_sahiplen_home_view.dart';
import 'package:patily/feature/patily_sahiplen/view/patilla_insert_view.dart';
import 'package:patily/feature/patily_sahiplen/viewmodel/patily_sahiplen_view_model.dart';

class MainPatilySahiplen extends StatefulWidget {
  const MainPatilySahiplen({Key? key}) : super(key: key);

  @override
  State<MainPatilySahiplen> createState() => _MainPatilySahiplenState();
}

class _MainPatilySahiplenState extends BaseState<MainPatilySahiplen> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const PatilySahiplenHomeView(),
    FavoritesView(),
    const AddView(),
    ChatSelectView(),
    const PatilySahiplenInsertView(),
  ];

  late MainPatillaViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<MainPatillaViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: MainPatillaViewModel(),
      onPageBuilder: (context, value) {
        return _buildScaffold;
      },
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        bottomNavigationBar: _bottomNavBar,
        body: pages[_selectedIndex],
      );

  BottomNavigationBar get _bottomNavBar => BottomNavigationBar(
        backgroundColor: LightThemeColors.scaffoldBackgroundColor,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          _homeBottomNavigation,
          _favsBottomNavigation,
          _addBottomNavigation,
          _chatsBottomNavigation,
          _insertBottomNavigation,
        ],
      );

  BottomNavigationBarItem get _homeBottomNavigation => BottomNavigationBarItem(
        icon: _homeIcon(),
        label: LocaleKeys.patilySahiplenPages_animalAdopt.locale,
      );

  SvgPicture _homeIcon() => SvgPicture.asset(
        _selectedIndex == 0 ? Assets.svg.home : Assets.svg.homeOutline,
        color: _selectedIndex == 0
            ? LightThemeColors.miamiMarmalade
            : LightThemeColors.grey,
        height: 25,
      );

  BottomNavigationBarItem get _favsBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 1
            ? const Icon(AppIcons.favoriteIcon)
            : const Icon(AppIcons.favoriteBorderIcon),
        label: LocaleKeys.patilySahiplenPages_myFavorites.locale,
      );

  BottomNavigationBarItem get _addBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 2
            ? const Icon(AppIcons.addCircleIcon)
            : const Icon(AppIcons.addCircleOutlinedIcon),
        label: LocaleKeys.patilySahiplenPages_addAPet.locale,
      );

  BottomNavigationBarItem get _chatsBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 3
            ? SvgPicture.asset(Assets.svg.chat,
                color: LightThemeColors.miamiMarmalade)
            : SvgPicture.asset(Assets.svg.chat, color: LightThemeColors.grey),
        label: LocaleKeys.patilySahiplenPages_myMessages.locale,
      );

  BottomNavigationBarItem get _insertBottomNavigation =>
      BottomNavigationBarItem(
        icon: _selectedIndex == 4
            ? const Icon(AppIcons.insertOutlineIcon)
            : const Icon(AppIcons.insertOutlineIcon),
        label: LocaleKeys.patilySahiplenPages_my_inserts.locale,
      );
}
