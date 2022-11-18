import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/auth_view/login_view/login_view.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:petilla_app_project/core/init/cache/locale_manager.dart';

class OnboardingViewModel {
  void onGetStartedButton(context) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool(SharedPreferencesKeyConstants.showHomeConstant, true).then(
    //       (value) => Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => LoginView(),
    //         ),
    //         (route) => false,
    //       ),
    //     );

    await LocaleManager.instance.setBoolValue(SharedKeys.SHOWHOME, true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      (route) => false,
    );
  }
}
