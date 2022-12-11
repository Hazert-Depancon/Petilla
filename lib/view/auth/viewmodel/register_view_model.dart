import 'package:flutter/material.dart';
import 'package:petilla_app_project/main.dart';
import 'package:petilla_app_project/view/auth/service/auth_service.dart';

class RegisterViewModel {
  Future<void> onRegisterButton(email, password, name, context) async {
    AuthService()
        .register(
          email.trim(),
          password.trim(),
          name.trim(),
          context,
        )
        .whenComplete(
          () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Petilla(showHome: true),
            ),
            (route) => false,
          ),
        );
  }
}
