import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';

class OnboardingPageTwo extends StatelessWidget {
  const OnboardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_svgPicTwo(context), const SizedBox(height: 24), _textTwo(context)],
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
