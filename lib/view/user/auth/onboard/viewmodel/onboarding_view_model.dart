// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petilla_app_project/core/constants/app/router_contants.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:petilla_app_project/core/init/cache/locale_manager.dart';

class OnboardingViewModel {
  void onGetStartedButton(BuildContext context) async {
    await LocaleManager.instance.setBoolValue(SharedKeys.SHOWHOME, true);
    context.replaceNamed(RouterConstants.login);
  }
}
