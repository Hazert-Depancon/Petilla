// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/auth/service/auth_service.dart';
import 'package:patily/feature/auth/view/register_view.dart';
import 'package:patily/main.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
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

  @action
  void callRegisterView(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterView(),
      ),
    );
  }
}
