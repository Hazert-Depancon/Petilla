// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:petilla_app_project/core/init/cache/locale_manager.dart';
import 'package:petilla_app_project/view/auth/view/login_view.dart';

class OnboardingViewModel {
  void onGetStartedButton(BuildContext context) async {
    await LocaleManager.instance.setBoolValue(SharedKeys.SHOWHOME, true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      (route) => false,
    );
  }
}
