// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes/project_padding.dart';
import 'package:petilla_app_project/general/general_view/profile_view.dart';
import 'package:petilla_app_project/general/general_widgets/select_app_widget.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class SelectAppView extends StatefulWidget {
  const SelectAppView({Key? key}) : super(key: key);

  @override
  State<SelectAppView> createState() => _SelectAppViewState();
}

class _SelectAppViewState extends State<SelectAppView> {
  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Petilla"),
        centerTitle: true,
        actions: [
          _profileAction(context),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            mainSizedBox,
            Padding(
              padding: ProjectPaddings.horizontalMainPadding,
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: _selectPetilla(),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1.5,
                    child: _selectPetform(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SelectAppWidget _selectPetform() {
    return const SelectAppWidget(
      title: 'Petform',
      imagePath: "assets/images/petform.png",
      onTap: MainPetForm(),
    );
  }

  SelectAppWidget _selectPetilla() {
    return SelectAppWidget(
      isBig: true,
      title: "app_name".tr(),
      imagePath: "assets/images/petilla_image.png",
      onTap: const MainPetilla(),
    );
  }

  GestureDetector _profileAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _callProfileView(context);
      },
      child: const Icon(AppIcons.personOutlineIcon, color: LightThemeColors.miamiMarmalade),
    );
  }

  void _callProfileView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileView()));
  }
}

class ThisPageTexts {
  static const String title = "Petilla";
}
