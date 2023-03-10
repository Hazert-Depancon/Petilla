import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';

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
  String msg1 = LocaleKeys.onboardTexts_onboarding_msg_one.locale;

  return Text(
    msg1,
    style: Theme.of(context).textTheme.headlineMedium,
    textAlign: TextAlign.center,
  );
}

SvgPicture _svgPicOne(BuildContext context) {
  return SvgPicture.asset(
    Assets.svg.onboardingOne,
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height * 0.35,
  );
}
