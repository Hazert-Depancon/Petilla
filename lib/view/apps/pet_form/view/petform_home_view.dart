// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/dialogs/error_dialog.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/apps/pet_form/viewmodel/petform_home_view_model.dart';

class PetformHomeView extends StatelessWidget {
  PetformHomeView({Key? key}) : super(key: key);

  late PetformHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<PetformHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: PetformHomeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(context) => Scaffold(
        appBar: _appBar(context),
        body: _body(context),
        floatingActionButton: _addGroup(context),
      );

  Column _body(BuildContext context) {
    return Column(
      children: [
        _generalListtile(context),
        _dogListTile(context),
        _catListTile(context),
        _rabbitListTile(context),
        _fishListTile(context),
      ],
    );
  }

  ListTile _fishListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.fish,
      ImageConstants.instance.fish,
      "fish_messages",
      "fish_chat",
      _ThisPageTexts.fishChat,
      context,
    );
  }

  ListTile _rabbitListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.rabbit,
      ImageConstants.instance.rabbit,
      "rabbit_messages",
      "rabbit_chat",
      _ThisPageTexts.rabbitChat,
      context,
    );
  }

  ListTile _catListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.cat,
      ImageConstants.instance.cat,
      "cat_messages",
      "cat_chat",
      _ThisPageTexts.catChat,
      context,
    );
  }

  ListTile _dogListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.dog,
      ImageConstants.instance.dog,
      "dog_messages",
      "dog_chat",
      _ThisPageTexts.dogChat,
      context,
    );
  }

  ListTile _generalListtile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.generalChat,
      ImageConstants.instance.general,
      "general_messages",
      "general_chat",
      _ThisPageTexts.generalChat,
      context,
    );
  }

  ListTile _listTile(String title, String assetName, String collectionId, String docId, String pageTitle, context) {
    return ListTile(
      title: Text(title),
      leading: SvgPicture.asset(assetName, height: 32),
      onTap: () {
        viewModel.callGroupChatView(title, assetName, collectionId, docId, pageTitle, context);
      },
    );
  }

  AppBar _appBar(context) {
    return AppBar(
      title: Text(_ThisPageTexts.selectGroup),
      foregroundColor: LightThemeColors.miamiMarmalade,
      leading: _backIcon(context),
    );
  }

  GestureDetector _backIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(AppIcons.arrowBackIcon),
    );
  }

  FloatingActionButton _addGroup(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _awesomeDialog(context);
      },
      child: const Icon(AppIcons.groupAddOutlinedIcon),
    );
  }

  _awesomeDialog(BuildContext context) {
    showErrorDialog(true, _ThisPageTexts.groupAddNotYet, context);
  }
}

class _ThisPageTexts {
  static String selectGroup = LocaleKeys.selectAGroup.locale;
  static String groupAddNotYet = LocaleKeys.groupAddNotYet.locale;
  static String generalChat = LocaleKeys.generalChat.locale;
  static String dog = LocaleKeys.dog.locale;
  static String dogChat = LocaleKeys.dogChat.locale;
  static String cat = LocaleKeys.cat.locale;
  static String catChat = LocaleKeys.catChat.locale;
  static String rabbit = LocaleKeys.rabbit.locale;
  static String rabbitChat = LocaleKeys.rabbitChat.locale;
  static String fish = LocaleKeys.fish.locale;
  static String fishChat = LocaleKeys.fishChat.locale;
}
