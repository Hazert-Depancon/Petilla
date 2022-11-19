import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/service/auth_service.dart';
import 'package:petilla_app_project/main.dart';

class LoginViewModel {
  Future<void> onLoginButton(context, email, password) async {
    await AuthService()
        .login(
          email.trim(),
          password.trim(),
          context,
        )
        .then(
          (e) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Petilla(showHome: true),
            ),
            (route) => false,
          ),
        );
  }
}
