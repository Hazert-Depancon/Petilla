import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/extension/string_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/utility/asset_utils/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/core/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constant/sizes_constant/project_padding.dart';

// ignore: must_be_immutable
class OnboardingOneView extends StatelessWidget {
  OnboardingOneView({super.key});
  var mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicOne(context),
          mainHeightSizedBox,
          _textOne(context),
        ],
      ),
    );
  }
}

Text _textOne(BuildContext context) {
  String msg1 = LocaleKeys.onboardingMsgOne.locale;

  return Text(
    msg1,
    style: Theme.of(context).textTheme.titleLarge,
    textAlign: TextAlign.center,
  );
}

SvgPicture _svgPicOne(BuildContext context) {
  return SvgPicture.asset(
    svgBuildConstant("onboarding_one"),
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height * 0.35,
  );
}
