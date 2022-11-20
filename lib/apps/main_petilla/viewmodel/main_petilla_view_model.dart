// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';

part 'main_petilla_view_model.g.dart';

class MainPetillaViewModel = _MainPetillaViewModelBase with _$MainPetillaViewModel;

abstract class _MainPetillaViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
