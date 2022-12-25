// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/help_me/viewmodel/help_me_view_view_model.dart';

class HelpMeHomeView extends StatefulWidget {
  const HelpMeHomeView({super.key});

  @override
  State<HelpMeHomeView> createState() => _HelpMeHomeViewState();
}

class _HelpMeHomeViewState extends BaseState<HelpMeHomeView> {
  final smallHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;

  final normalWidthSizedBox = AppSizedBoxs.normalWidthSizedBox;

  late HelpMeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpMeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: HelpMeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(context) => Scaffold(
        endDrawer: _endDrawer(context),
        appBar: AppBar(
          title: const Text("Yardım Et!"),
          foregroundColor: LightThemeColors.miamiMarmalade,
          actions: [
            _helpMe(),
            normalWidthSizedBox,
            _filterButton(),
            normalWidthSizedBox,
          ],
        ),
      );

  Drawer _endDrawer(context) => Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12) + const EdgeInsets.only(left: 16, right: 4),
              child: Row(
                children: [
                  _drawerTitle(context),
                ],
              ),
            ),
          ],
        ),
      );

  Text _drawerTitle(BuildContext context) {
    return Text(
      LocaleKeys.filter.locale,
      style: textTheme.titleLarge!.copyWith(
        color: LightThemeColors.miamiMarmalade,
        fontSize: 22,
      ),
    );
  }

  GestureDetector _helpMe() => GestureDetector(
        onTap: () {},
        child: const Icon(Icons.add_a_photo_outlined),
      );

  Builder _filterButton() {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: const Icon(
            AppIcons.filterIcon,
          ),
        );
      },
    );
  }
}
