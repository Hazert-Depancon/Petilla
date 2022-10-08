// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';

class OnboardingPageThree extends StatelessWidget {
  OnboardingPageThree({super.key});
  var mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicThree(context),
          mainHeightSizedBox,
          _textThree(context),
        ],
      ),
    );
  }
}

Text _textThree(BuildContext context) {
  var msg3 = "onboarding_msg_three".tr();

  return Text(
    msg3,
    style: Theme.of(context).textTheme.titleLarge,
    textAlign: TextAlign.center,
  );
}

SvgPicture _svgPicThree(BuildContext context) {
  return SvgPicture.asset(
    svgBuildConstant("onboarding_three"),
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height * 0.35,
  );
}
