import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/user/auth/service/auth_service.dart';
import 'package:petilla_app_project/view/user/auth/view/login_view.dart';

class ProfileViewModel {
  Future<void> logOut(context) async {
    AuthService().logout(context).then(
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
