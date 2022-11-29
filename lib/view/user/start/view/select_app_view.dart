// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/animal_report/view/main_animal_report.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/main_petilla.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/view/user/start/core/components/select_app_widget.dart';
import 'package:petilla_app_project/view/user/start/viewmodel/select_app_view_view_model.dart';

class SelectAppView extends StatelessWidget {
  SelectAppView({Key? key}) : super(key: key);

  final mainSizedBox = AppSizedBoxs.mainHeightSizedBox;
  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;

  late SelectAppViewViewModel viewModel;

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
        body: _body(),
      );

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
    return SingleChildScrollView(
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
                _selectAnimalReportGridTile(),
              ],
            ),
          ),
        ],
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

  StaggeredGridTile _selectAnimalReportGridTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: _selectAnimalReport(),
    );
  }

  SelectAppWidget _selectPetform() {
    return SelectAppWidget(
      title: _ThisPageTexts.petformTitle,
      imagePath: ImageConstants.instance.petform,
      onTap: const MainPetForm(),
    );
  }

  SelectAppWidget _selectPetilla() {
    return SelectAppWidget(
      isBig: true,
      title: _ThisPageTexts.petillaTitle,
      imagePath: ImageConstants.instance.petilla,
      onTap: const MainPetilla(),
    );
  }

  SelectAppWidget _selectAnimalReport() {
    return SelectAppWidget(
      isBig: true,
      title: LocaleKeys.report.locale,
      imagePath: ImageConstants.instance.animalReport,
      onTap: const MainAnimalReport(),
    );
  }

  GestureDetector _profileAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.callProfileView();
      },
      child: const Icon(
        AppIcons.personOutlineIcon,
        color: LightThemeColors.miamiMarmalade,
      ),
    );
  }
}

class _ThisPageTexts {
  static String petformTitle = LocaleKeys.petform.locale;
  static String petillaTitle = LocaleKeys.petilla.locale;
}
