// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:patily/product/constants/enums/locale_keys_enum.dart';
import 'package:patily/product/init/cache/locale_manager.dart';
import 'package:patily/feature/auth/view/login_view.dart';

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
