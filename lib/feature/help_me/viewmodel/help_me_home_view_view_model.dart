// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';

part 'help_me_home_view_view_model.g.dart';

class HelpMeHomeViewViewModel = _HelpMeViewViewModelBase
    with _$HelpMeHomeViewViewModel;

abstract class _HelpMeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
