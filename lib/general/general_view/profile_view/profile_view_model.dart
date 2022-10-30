import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/auth/auth_view/login_view/login_view.dart';

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
