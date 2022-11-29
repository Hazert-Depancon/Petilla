// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/app/router_contants.dart';
part 'select_app_view_view_model.g.dart';

class SelectAppViewViewModel = _SelectAppViewViewModelBase with _$SelectAppViewViewModel;

abstract class _SelectAppViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callProfileView() {
    viewModelContext.pushNamed(RouterConstants.profile);
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
  }
}
