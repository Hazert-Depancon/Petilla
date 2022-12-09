// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/admin/core/models/reported_pet_model.dart';
import 'package:petilla_app_project/view/admin/viewmodel/reported_pet_detail_view_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReportedPetDetailView extends StatelessWidget {
  ReportedPetDetailView({super.key, required this.petModel});
  final ReportedPetModel petModel;

  late ReportedPetDetailViewViewModel viewModel;
  String noImage = "https://ispark.istanbul/wp-content/themes/ispark2019/images/gorselyok.png";
  var mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return BaseView<ReportedPetDetailViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: ReportedPetDetailViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(context) => Scaffold(
        appBar: _appBar,
        body: _body(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            String googleURL = "https://www.google.com/maps/search/?api=1&query=${petModel.lat},${petModel.long}";
            await canLaunchUrlString(googleURL) ? await launchUrlString(googleURL) : throw "ERROR";
          },
          label: Text(LocaleKeys.location.locale),
          icon: const Icon(AppIcons.locationOnOtlinedIcon),
        ),
      );

  AppBar get _appBar => AppBar(
        foregroundColor: LightThemeColors.miamiMarmalade,
      );

  SingleChildScrollView _body(context) {
    return SingleChildScrollView(
      padding: ProjectPaddings.horizontalMainPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _currentNameText(context),
          mainHeightSizedBox,
          _imageContainer(),
          mainHeightSizedBox,
          _descriptionText(context),
          mainHeightSizedBox,
          _phoneNumberText(context),
          mainHeightSizedBox,
          _isDamagedText(context)
        ],
      ),
    );
  }

  Text _isDamagedText(context) {
    return Text(
      petModel.isDamaged == true ? LocaleKeys.animalDamaged.locale : LocaleKeys.animalDontDamaged.locale,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  Text _currentNameText(context) {
    return Text(
      petModel.currentName,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  GestureDetector _phoneNumberText(context) {
    return GestureDetector(
      onTap: () {
        launch("tel://${petModel.phoneNumber}");
      },
      child: Text(
        petModel.phoneNumber,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  Text _descriptionText(context) {
    return Text(
      petModel.description,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Container _imageContainer() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: LightThemeColors.miamiMarmalade,
        borderRadius: ProjectRadius.mainAllRadius,
        image: DecorationImage(
          image: NetworkImage(petModel.imagePath ?? noImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
