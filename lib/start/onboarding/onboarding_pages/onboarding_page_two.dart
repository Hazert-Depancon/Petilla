// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';

class OnboardingPageTwo extends StatelessWidget {
  OnboardingPageTwo({super.key});
  var mainHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicTwo(context),
          mainHeightSizedBox,
          _textTwo(context),
        ],
      ),
    );
  }
}

Text _textTwo(BuildContext context) {
  var msg2 = "onboarding_msg_two".tr();

  return Text(
    msg2,
    style: Theme.of(context).textTheme.titleLarge,
    textAlign: TextAlign.center,
  );
}

SvgPicture _svgPicTwo(BuildContext context) {
  return SvgPicture.asset(
    svgBuildConstant("onboarding_two"),
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height * 0.35,
  );
}
