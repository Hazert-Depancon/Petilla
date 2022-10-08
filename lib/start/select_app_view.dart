import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/constant/assets_build_constant/image_build_constant.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/general/general_view/profile_view.dart';
import 'package:petilla_app_project/general/general_widgets/select_app_widget.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

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
      title: Text(ThisPageTexts.title),
      centerTitle: true,
      actions: [
        _profileAction(context),
        smallWidthSizedBox,
      ],
    );
  }

  ListView _body() {
    return ListView(
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
      title: "Petform",
      imagePath: pngImageBuildConstant("petform"),
      onTap: const MainPetForm(),
    );
  }

  SelectAppWidget _selectPetilla() {
    return SelectAppWidget(
      isBig: true,
      title: ThisPageTexts.title,
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

class ThisPageTexts {
  static String title = "app_name".tr();
  static String petformTitle = "petform".tr();
}
