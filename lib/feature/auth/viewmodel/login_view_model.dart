import 'package:flutter/material.dart';
import 'package:patily/feature/auth/service/auth_service.dart';
import 'package:patily/feature/auth/view/register_view.dart';
import 'package:patily/main.dart';

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
              builder: (context) => const Patily(showHome: true),
            ),
            (route) => false,
          ),
        );
  }

  void callRegisterView(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterView(),
      ),
    );
  }
}
