// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/banner_ad_widget.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';
import 'package:petilla_app_project/view/user/apps/help_me/view/help_me_control.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/main_petilla.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/view/user/apps/petcook/view/petcook_control_view.dart';
import 'package:petilla_app_project/view/user/start/core/components/select_app_widget.dart';
import 'package:petilla_app_project/view/user/start/viewmodel/select_app_view_view_model.dart';

class SelectAppView extends StatefulWidget {
  const SelectAppView({Key? key}) : super(key: key);

  @override
  State<SelectAppView> createState() => _SelectAppViewState();
}

class _SelectAppViewState extends State<SelectAppView> {
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
            SelectAppWidget(
              title: LocaleKeys.petilla.locale,
              description: LocaleKeys.petillaDescription.locale,
              imagePath: Assets.images.petillaImage.path,
              onTap: const MainPetilla(),
            ),
            mainSizedBox,
            SelectAppWidget(
              title: LocaleKeys.petform.locale,
              description: LocaleKeys.petformDescription.locale,
              imagePath: Assets.images.petform.path,
              onTap: const MainPetForm(),
            ),
            mainSizedBox,
            SelectAppWidget(
              title: LocaleKeys.helpMe.locale,
              description: LocaleKeys.helpMeDescription.locale,
              imagePath: Assets.images.helpMe.path,
              onTap: const HelpMeControl(),
            ),
            mainSizedBox,
            SelectAppWidget(
              title: "Petcook",
              description: "Hayvanlar için sosyal medya!",
              imagePath: Assets.images.petCookImage.path,
              onTap: const PetCookControlView(),
            ),
          ],
        ),
      ),
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
  static String petillaTitle = LocaleKeys.petilla.locale;
}
