import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';

class OnboardingPageThree extends StatelessWidget {
  const OnboardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicThree(context),
          const SizedBox(height: 24),
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
