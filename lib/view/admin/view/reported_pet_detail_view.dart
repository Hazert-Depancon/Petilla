// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/admin/core/models/reported_pet_model.dart';
import 'package:petilla_app_project/view/admin/viewmodel/reported_pet_detail_view_view_model.dart';

class ReportedPetDetailView extends StatelessWidget {
  ReportedPetDetailView({super.key, required this.petModel});
  final ReportedPetModel petModel;

  late ReportedPetDetailViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<ReportedPetDetailViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: ReportedPetDetailViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold,
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        appBar: _appBar,
      );

  AppBar get _appBar => AppBar(
        foregroundColor: LightThemeColors.miamiMarmalade,
      );
}
