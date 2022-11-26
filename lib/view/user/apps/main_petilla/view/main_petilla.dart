import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/add_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/chat_select_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/favorites_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/petilla_home_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/petilla_insert_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/viewmodel/main_petilla_view_model.dart';

class MainPetilla extends StatefulWidget {
  const MainPetilla({Key? key}) : super(key: key);

  @override
  State<MainPetilla> createState() => _MainPetillaState();
}

class _MainPetillaState extends BaseState<MainPetilla> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const PetillaHomeView(),
    FavoritesView(),
    const AddView(),
    ChatSelectView(),
    const PetillaInsertView(),
  ];

  late MainPetillaViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<MainPetillaViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: MainPetillaViewModel(),
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
        backgroundColor: LightThemeColors.white,
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
        label: LocaleKeys.homePage.locale,
      );

  SvgPicture _homeIcon() => SvgPicture.asset(
        _selectedIndex == 0 ? ImageConstants.instance.home : ImageConstants.instance.homeOutline,
        color: _selectedIndex == 0 ? LightThemeColors.miamiMarmalade : LightThemeColors.grey,
        height: 25,
      );

  BottomNavigationBarItem get _favsBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 1 ? const Icon(AppIcons.favoriteIcon) : const Icon(AppIcons.favoriteBorderIcon),
        label: LocaleKeys.myFavorites.locale,
      );

  BottomNavigationBarItem get _addBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 2 ? const Icon(AppIcons.addCircleIcon) : const Icon(AppIcons.addCircleOutlinedIcon),
        label: LocaleKeys.addAPet.locale,
      );

  BottomNavigationBarItem get _chatsBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 3 ? const Icon(AppIcons.chatIcon) : const Icon(AppIcons.chatOutlinedIcon),
        label: LocaleKeys.myMessages.locale,
      );

  BottomNavigationBarItem get _insertBottomNavigation => BottomNavigationBarItem(
        icon: _selectedIndex == 4 ? const Icon(AppIcons.insertOutlineIcon) : const Icon(AppIcons.insertOutlineIcon),
        label: LocaleKeys.myInserts.locale,
      );
}
