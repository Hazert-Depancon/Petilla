// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/auth/service/auth_service.dart';
import 'package:patily/feature/auth/view/login_view.dart';

part 'profile_view_view_model.g.dart';

class ProfileViewViewModel = _ProfileViewViewModelBase
    with _$ProfileViewViewModel;

abstract class _ProfileViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  Future<void> logOut() async {
    AuthService().logout(viewModelContext).then(
          (value) => Navigator.pushAndRemoveUntil(
            viewModelContext,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
            (route) => false,
          ),
        );
  }

  @action
  Future<void> deleteAccount() async {
    AuthService().deleteUser(viewModelContext);
  }
}
