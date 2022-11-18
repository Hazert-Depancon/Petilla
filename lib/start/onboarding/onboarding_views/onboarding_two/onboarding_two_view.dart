// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';

class OnboardingTwoView extends StatelessWidget {
  OnboardingTwoView({super.key});
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
  var msg2 = LocaleKeys.onboardingMsgTwo.locale;

  return Text(
    msg2,
    style: Theme.of(context).textTheme.titleLarge,
    textAlign: TextAlign.center,
  );
}

SvgPicture _svgPicTwo(BuildContext context) {
  return SvgPicture.asset(
    ImageConstants.instance.onboardingTwo,
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height * 0.35,
  );
}
