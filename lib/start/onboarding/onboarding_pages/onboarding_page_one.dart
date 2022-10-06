import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicOne(context),
          const SizedBox(height: 24),
          _textOne(context),
        ],
      ),
    );
  }
}

Text _textOne(BuildContext context) {
  String msg1 = "onboarding_msg_one".tr();

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
