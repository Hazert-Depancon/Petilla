// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/auth/service/auth_service.dart';
import 'package:patily/feature/auth/view/login_view.dart';
import 'package:patily/main.dart';

part 'register_view_model.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  Future<void> onRegisterButton(TextEditingController email,
      TextEditingController password, TextEditingController name) async {
    AuthService()
        .register(
          email.text.trim(),
          password.text.trim(),
          name.text.trim(),
          context,
        )
        .whenComplete(
          () => Navigator.pushAndRemoveUntil(
            viewModelContext,
            MaterialPageRoute(
              builder: (context) => const Patily(showHome: true),
            ),
            (route) => false,
          ),
        );
  }

  @action
  void callLoginView() {
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }
}
