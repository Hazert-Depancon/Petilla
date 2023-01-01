// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/button.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/help_me/core/models/help_me_model.dart';
import 'package:petilla_app_project/view/user/apps/help_me/viewmodel/help_me_detail_view_view_model.dart';

class HelpMeDetailView extends StatelessWidget {
  HelpMeDetailView({super.key, required this.helpMeModel});
  final HelpMeModel helpMeModel;

  late HelpMeDetailViewViewModel viewModel;

  final mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;
  final normalWidthSizedBox = AppSizedBoxs.normalWidthSizedBox;

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpMeDetailViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: HelpMeDetailViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(context),
        bottomNavigationBar: Padding(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Row(
            children: [
              _showInMapButton(),
              normalWidthSizedBox,
              _chatButton(context),
            ],
          ),
        ),
      );

  FloatingActionButton _chatButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(AppIcons.chatIcon),
      onPressed: () {
        viewModel.callChatPage(
          context,
          helpMeModel.currentUserName,
          helpMeModel.currentUserId,
          helpMeModel.currentUserId,
        );
      },
    );
  }

  Expanded _showInMapButton() {
    return Expanded(
      child: Button(
        text: "Konumu Göster",
        onPressed: () async {
          viewModel.showInMap(helpMeModel);
        },
        height: 55,
      ),
    );
  }

  SingleChildScrollView _body(context) {
    return SingleChildScrollView(
      padding: ProjectPaddings.horizontalMainPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageContainer(),
          mainHeightSizedBox,
          _titleText(context),
          mainHeightSizedBox,
          _descriptionText(context),
          mainHeightSizedBox,
          helpMeModel.isFoodHelp ? _footdHelpText(context) : _emptySizedBox(),
          helpMeModel.isFoodHelp ? mainHeightSizedBox : _emptySizedBox(),
          helpMeModel.isVetHelp ? _vetHelpText(context) : _emptySizedBox(),
        ],
      ),
    );
  }

  SizedBox _emptySizedBox() => const SizedBox.shrink();

  Text _vetHelpText(context) => Text(LocaleKeys.vetHelp.locale, style: Theme.of(context).textTheme.subtitle2);

  Text _footdHelpText(context) => Text(LocaleKeys.foodHelp.locale, style: Theme.of(context).textTheme.subtitle2);

  Text _descriptionText(context) => Text(helpMeModel.description, style: Theme.of(context).textTheme.headline6);

  Text _titleText(context) => Text(helpMeModel.title, style: Theme.of(context).textTheme.headline4);

  Container _imageContainer() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: ProjectRadius.allRadius,
        image: DecorationImage(
          image: NetworkImage(
            helpMeModel.imageDowlandUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar();
}
