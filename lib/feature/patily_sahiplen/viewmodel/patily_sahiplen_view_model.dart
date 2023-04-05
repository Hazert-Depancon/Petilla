// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';

part 'patily_sahiplen_view_model.g.dart';

class MainPatillaViewModel = _MainPatillaViewModelBase
    with _$MainPatillaViewModel;

abstract class _MainPatillaViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
