import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';

class InChatViewViewModel = _InChatViewViewModelBase with _InChatViewViewModel;

abstract class _InChatViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
