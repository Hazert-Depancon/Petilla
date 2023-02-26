// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/banner_ad_widget.dart';
import 'package:petilla_app_project/core/components/dialogs/error_dialog.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/viewmodel/petform_home_view_model.dart';

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
        bottomNavigationBar: const AdWidgetBanner(),
      );

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _generalListTile(context),
          _dogListTile(context),
          _catListTile(context),
          _rabbitListTile(context),
          _fishListTile(context),
        ],
      ),
    );
  }

  _fishListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.fish,
      Assets.svg.fish,
      "fish_messages",
      "fish_chat",
      _ThisPageTexts.fishChat,
      context,
    );
  }

  _rabbitListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.rabbit,
      Assets.svg.rabbit,
      "rabbit_messages",
      "rabbit_chat",
      _ThisPageTexts.rabbitChat,
      context,
    );
  }

  _catListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.cat,
      Assets.svg.cat,
      "cat_messages",
      "cat_chat",
      _ThisPageTexts.catChat,
      context,
    );
  }

  _dogListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.dog,
      Assets.svg.dog,
      "dog_messages",
      "dog_chat",
      _ThisPageTexts.dogChat,
      context,
    );
  }

  _generalListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.generalChat,
      Assets.svg.language,
      "general_messages",
      "general_chat",
      _ThisPageTexts.generalChat,
      context,
    );
  }

  Observer _listTile(String title, String assetName, String collectionId,
      String docId, String pageTitle, context) {
    return Observer(builder: (_) {
      return ListTile(
        title: Text(title),
        leading: SvgPicture.asset(assetName, height: 32),
        onTap: () {
          viewModel.callGroupChatView(
              title, assetName, collectionId, docId, pageTitle, context);
        },
      );
    });
  }

  AppBar _appBar(context) {
    return AppBar(
      title: Text(_ThisPageTexts.selectGroup),
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
  static String dog = LocaleKeys.animalNames_dog.locale;
  static String dogChat = LocaleKeys.dogChat.locale;
  static String cat = LocaleKeys.animalNames_cat.locale;
  static String catChat = LocaleKeys.catChat.locale;
  static String rabbit = LocaleKeys.animalNames_rabbit.locale;
  static String rabbitChat = LocaleKeys.rabbitChat.locale;
  static String fish = LocaleKeys.animalNames_fish.locale;
  static String fishChat = LocaleKeys.fishChat.locale;
}
