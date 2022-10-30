import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/main.dart';

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
