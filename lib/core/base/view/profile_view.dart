// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/base/viewmodel/profile_view_view_model.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/view/user/other/view/about_view.dart';
import 'package:petilla_app_project/view/user/other/view/feedback_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;
  final smallHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;

  final _firestore = FirebaseFirestore.instance;

  late ProfileViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: ProfileViewViewModel(),
      onPageBuilder: (context, value) => buildScaffold(context),
    );
  }

  Scaffold buildScaffold(context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _streamBodyBuilder(),
    );
  }

  AppBar _appBar(context) {
    return AppBar(
      title: Text(_ThisPageTexts.title),
      actions: [settingsIcon(context), smallWidthSizedBox],
    );
  }

  GestureDetector settingsIcon(context) {
    return GestureDetector(
      onTap: () {
        _settingBottomSheet(context);
      },
      child: const Icon(
        AppIcons.setting,
        color: LightThemeColors.black,
      ),
    );
  }

  Future<dynamic> _settingBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              _listTile(context, AppIcons.info, LocaleKeys.about, const AboutView()),
              _listTile(context, AppIcons.feed, LocaleKeys.feedBack, FeedBackView()),
              _listTile(context, AppIcons.link, LocaleKeys.links, FeedBackView()),
            ],
          ),
        );
      },
    );
  }

  ListTile _listTile(BuildContext context, IconData icon, String text, Widget route) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32,
        color: LightThemeColors.black,
      ),
      title: Text(
        text.locale,
        style: Theme.of(context).textTheme.headline6,
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
    );
  }

  StreamBuilder<DocumentSnapshot> _streamBodyBuilder() {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String name = snapshot.data![AppFirestoreFieldNames.nameField];
          String email = snapshot.data![AppFirestoreFieldNames.emailField];
          return _hasDataScreen(snapshot, name, email, context);
        }
        if (snapshot.hasError) {
          return _errorLottie;
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return _connectionErrorLottie;
        }
        return _loadingLottie;
      },
    );
  }

  StatusView get _loadingLottie => const StatusView(status: StatusKeysEnum.LOADING);
  StatusView get _errorLottie => const StatusView(status: StatusKeysEnum.ERROR);
  StatusView get _connectionErrorLottie => const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  SingleChildScrollView _hasDataScreen(snapshot, String name, String email, context) {
    return SingleChildScrollView(
      padding: ProjectPaddings.horizontalMainPadding,
      child: Column(
        children: [
          _circleAvatar(snapshot, name, context),
          smallHeightSizedBox,
          _nameTextfield(snapshot, name),
          smallHeightSizedBox,
          _emailTextfield(snapshot, email),
          smallHeightSizedBox,
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                viewModel.logOut();
              },
              child: Text(
                LocaleKeys.logout.locale,
                style: const TextStyle(
                  color: LightThemeColors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  MainTextField _emailTextfield(snapshot, String email) {
    return MainTextField(
      enabled: false,
      prefixIcon: const Icon(AppIcons.emailOutlinedIcon),
      hintText: email,
    );
  }

  MainTextField _nameTextfield(snapshot, String name) {
    return MainTextField(
      enabled: false,
      prefixIcon: const Icon(AppIcons.personOutlineIcon),
      hintText: name,
    );
  }

  CircleAvatar _circleAvatar(snapshot, String name, context) {
    return CircleAvatar(
      radius: 60,
      child: Center(
        child: Text(
          name.substring(0, 1),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

class _ThisPageTexts {
  static String title = LocaleKeys.profile.locale;
}
