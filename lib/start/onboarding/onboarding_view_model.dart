import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/auth_view/login_view/login_view.dart';
import 'package:petilla_app_project/constant/strings_constant/shared_preferences_key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingViewModel {
  void onGetStartedButton(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPreferencesKeyConstants.showHomeConstant, true).then(
          (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
            (route) => false,
          ),
        );
  }
}
