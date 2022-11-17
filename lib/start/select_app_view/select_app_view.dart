import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/utility/asset_utils/assets_build_constant/image_build_constant.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/general/general_view/profile_view/profile_view.dart';
import 'package:petilla_app_project/start/select_app_view/select_app_widgets/select_app_widget.dart';
import 'package:petilla_app_project/init/theme/light_theme/light_theme_colors.dart';

class SelectAppView extends StatelessWidget {
  const SelectAppView({Key? key}) : super(key: key);

  final mainSizedBox = AppSizedBoxs.mainHeightSizedBox;
  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(_ThisPageTexts.petillaTitle),
      centerTitle: true,
      foregroundColor: LightThemeColors.miamiMarmalade,
      automaticallyImplyLeading: false,
      actions: [
        _profileAction(context),
        smallWidthSizedBox,
      ],
    );
  }

  _body() {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            mainSizedBox,
            Padding(
              padding: ProjectPaddings.horizontalMainPadding,
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _selectPetillaGridTile(),
                  _selectPetformGridTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StaggeredGridTile _selectPetformGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: _selectPetform(),
    );
  }

  StaggeredGridTile _selectPetillaGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: _selectPetilla(),
    );
  }

  SelectAppWidget _selectPetform() {
    return SelectAppWidget(
      title: _ThisPageTexts.petformTitle,
      imagePath: pngImageBuildConstant("petform"),
      onTap: const MainPetForm(),
    );
  }

  SelectAppWidget _selectPetilla() {
    return SelectAppWidget(
      isBig: true,
      title: _ThisPageTexts.petillaTitle,
      imagePath: pngImageBuildConstant("petilla_image"),
      onTap: const MainPetilla(),
    );
  }

  GestureDetector _profileAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _callProfileView(context);
      },
      child: const Icon(
        AppIcons.personOutlineIcon,
        color: LightThemeColors.miamiMarmalade,
      ),
    );
  }

  void _callProfileView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView()));
  }
}

class _ThisPageTexts {
  static String petformTitle = Localization.petform;
  static String petillaTitle = Localization.petilla;
}
