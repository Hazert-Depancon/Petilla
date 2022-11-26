import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:petilla_app_project/core/init/cache/locale_manager.dart';
import 'package:petilla_app_project/view/user/auth/view/login_view.dart';

class OnboardingViewModel {
  void onGetStartedButton(context) async {
    await LocaleManager.instance.setBoolValue(SharedKeys.SHOWHOME, true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      (route) => false,
    );
  }
}
