import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/pet_form/pet_form_view/main_pet_form_view/group_template.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/general/general_widgets/dialogs/error_dialog.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class PetformHomeView extends StatelessWidget {
  const PetformHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
      floatingActionButton: _addGroup(context),
    );
  }

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
      "fish",
      "fish_messages",
      "fish_chat",
      _ThisPageTexts.fishChat,
      context,
    );
  }

  ListTile _rabbitListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.rabbit,
      "rabbit",
      "rabbit_messages",
      "rabbit_chat",
      _ThisPageTexts.rabbitChat,
      context,
    );
  }

  ListTile _catListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.cat,
      "cat",
      "cat_messages",
      "cat_chat",
      _ThisPageTexts.catChat,
      context,
    );
  }

  ListTile _dogListTile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.dog,
      "dog",
      "dog_messages",
      "dog_chat",
      _ThisPageTexts.dogChat,
      context,
    );
  }

  ListTile _generalListtile(BuildContext context) {
    return _listTile(
      _ThisPageTexts.generalChat,
      "language",
      "general_messages",
      "general_chat",
      _ThisPageTexts.generalChat,
      context,
    );
  }

  ListTile _listTile(String title, String assetName, String collectionId, String docId, String pageTitle, context) {
    return ListTile(
      title: Text(title),
      leading: SvgPicture.asset(svgBuildConstant(assetName), height: 32),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChat(
              collectionId: collectionId,
              docId: docId,
              pageTitle: pageTitle,
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_ThisPageTexts.selectGroup),
      foregroundColor: LightThemeColors.miamiMarmalade,
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
  static String selectGroup = "select_a_group".tr();
  static String groupAddNotYet = "select_a_group".tr();
  static String generalChat = "general_chat".tr();
  static String dog = "dog".tr();
  static String dogChat = "dog_chat".tr();
  static String cat = "cat".tr();
  static String catChat = "cat_chat".tr();
  static String rabbit = "rabbit".tr();
  static String rabbitChat = "rabbit_chat".tr();
  static String fish = "fish".tr();
  static String fishChat = "fishChat".tr();
}
