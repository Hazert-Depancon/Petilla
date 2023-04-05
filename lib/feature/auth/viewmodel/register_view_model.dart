import 'package:flutter/material.dart';
import 'package:patily/main.dart';
import 'package:patily/feature/auth/service/auth_service.dart';

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
              builder: (context) => const Patily(showHome: true),
            ),
            (route) => false,
          ),
        );
  }
}
