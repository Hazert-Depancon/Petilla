// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/google_ads/ads_state.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/animal_report/view/main_animal_report.dart';
import 'package:petilla_app_project/view/user/apps/help_me/view/help_me_control.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/main_petilla.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/view/user/start/core/components/select_app_widget.dart';
import 'package:petilla_app_project/view/user/start/viewmodel/select_app_view_view_model.dart';

class SelectAppView extends StatelessWidget {
  SelectAppView({Key? key}) : super(key: key);

  final mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;

  late SelectAppViewViewModel viewModel;

  BannerAd? _banner;

  void _createBannerAd() {
    _banner = AdmobManager().createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectAppViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        _createBannerAd();
      },
      viewModel: SelectAppViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(context) => Scaffold(
        appBar: _appBar(context),
        body: _body(context),
        bottomNavigationBar: _banner == null
            ? null
            : Container(
                margin: const EdgeInsets.only(bottom: 0),
                height: 52,
                child: AdWidget(
                  ad: _banner!,
                ),
              ),
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

  SingleChildScrollView _body(context) {
    return SingleChildScrollView(
      padding: ProjectPaddings.horizontalMainPadding,
      child: Column(
        children: [
          SelectAppWidget(
            title: LocaleKeys.petilla.locale,
            description: "Hayvan sahiplen ve sahiplendir",
            imagePath: ImageConstants.instance.petilla,
            onTap: const MainPetilla(),
          ),
          mainSizedBox,
          SelectAppWidget(
            title: LocaleKeys.petform.locale,
            description: "Sorunlarını hayvan sahipleri ile çöz!",
            imagePath: ImageConstants.instance.petform,
            onTap: const MainPetForm(),
          ),
          mainSizedBox,
          SelectAppWidget(
            title: LocaleKeys.helpMe.locale,
            description: "Sokak hayvanlarına yardım et!",
            imagePath: ImageConstants.instance.helpMe,
            onTap: const HelpMeControl(),
          ),
          mainSizedBox,
          SelectAppWidget(
            title: LocaleKeys.report.locale,
            description: "Zarar gördüğün hayvanları bildir!",
            imagePath: ImageConstants.instance.animalReport,
            onTap: const MainAnimalReport(),
          ),
        ],
      ),
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
