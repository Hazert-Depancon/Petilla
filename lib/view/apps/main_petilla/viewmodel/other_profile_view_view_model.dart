// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';

part 'other_profile_view_view_model.g.dart';

class OtherProfileViewViewModel = _OtherProfileViewViewModelBase with _$OtherProfileViewViewModel;

abstract class _OtherProfileViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
