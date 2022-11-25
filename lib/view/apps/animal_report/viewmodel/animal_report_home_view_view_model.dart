// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';

part 'animal_report_home_view_view_model.g.dart';

class AnimalReportHomeViewModel = _AnimalReportHomeViewModelBase with _$AnimalReportHomeViewModel;

abstract class _AnimalReportHomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
