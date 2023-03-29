// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/banner_ad_widget.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';
import 'package:petilla_app_project/view/user/apps/help_me/view/help_me_home_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/main_petilla.dart';
import 'package:petilla_app_project/view/user/apps/petform/main_pet_form.dart';
import 'package:petilla_app_project/view/user/apps/petcook/view/petcook_home_view.dart';
import 'package:petilla_app_project/view/user/start/core/components/select_app_widget.dart';
import 'package:petilla_app_project/view/user/start/viewmodel/select_app_view_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectAppView extends StatefulWidget {
  const SelectAppView({Key? key}) : super(key: key);

  @override
  State<SelectAppView> createState() => _SelectAppViewState();
}

class _SelectAppViewState extends State<SelectAppView> {
  final mainSizedBox = AppSizedBoxs.mainHeightSizedBox;
  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;
  late SelectAppViewViewModel viewModel;

  Future<void> instagramLaunch() async {
    var url = 'https://www.instagram.com/petilla_turkiye/';

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectAppViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: SelectAppViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(context) => Scaffold(
        appBar: _appBar(context),
        body: _body(context),
        bottomNavigationBar: const AdWidgetBanner(),
      );

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(_ThisPageTexts.petillaTitle),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        _profileAction(context),
        smallWidthSizedBox,
      ],
    );
  }

  SafeArea _body(context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                instagramLaunch();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.fallowInstagram.path),
                    fit: BoxFit.cover,
                  ),
                  color: LightThemeColors.white,
                  borderRadius: ProjectRadius.mainAllRadius,
                ),
              ),
            ),
            mainSizedBox,
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _selectPetillaGridTile(),
                _selectPetformGridTile(),
                _selectPatieGridTile(),
                _selectHelpMeGridTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  StaggeredGridTile _selectPetformGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: _selectPetform(),
    );
  }

  StaggeredGridTile _selectPatieGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: _selectPatie(),
    );
  }

  StaggeredGridTile _selectPetillaGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: _selectPetilla(),
    );
  }

  StaggeredGridTile _selectHelpMeGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: _selectHelpMe(),
    );
  }

  SelectAppWidget _selectPetform() {
    return SelectAppWidget(
      title: LocaleKeys.appNames_petform.locale,
      imagePath: Assets.images.petform.path,
      onTap: const MainPetForm(),
    );
  }

  SelectAppWidget _selectPatie() {
    return SelectAppWidget(
      title: LocaleKeys.appNames_patie.locale,
      imagePath: Assets.images.petCookImage.path,
      onTap: PetcookHomeView(),
    );
  }

  SelectAppWidget _selectHelpMe() {
    return SelectAppWidget(
      title: LocaleKeys.appNames_helpMe.locale,
      imagePath: Assets.images.helpMe.path,
      onTap: const HelpMeHomeView(),
    );
  }

  SelectAppWidget _selectPetilla() {
    return SelectAppWidget(
      isBig: true,
      title: LocaleKeys.appNames_patilla.locale,
      imagePath: Assets.images.petillaImage.path,
      onTap: const MainPetilla(),
    );
  }

  GestureDetector _profileAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.callProfileView();
      },
      child: SvgPicture.asset(
        Assets.svg.profile,
        color: LightThemeColors.miamiMarmalade,
        height: 28,
      ),
    );
  }
}

class _ThisPageTexts {
  static String petillaTitle = LocaleKeys.appNames_patilla.locale;
}
