// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/base/viewmodel/profile_view_view_model.dart';
import 'package:petilla_app_project/core/components/banner_ad_widget.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';
import 'package:petilla_app_project/view/auth/view/delete_account_confirm_view.dart';
import 'package:petilla_app_project/view/user/other/view/about_view.dart';
import 'package:petilla_app_project/view/user/other/view/feedback_view.dart';
import 'package:petilla_app_project/view/user/other/view/social_connection_view.dart';
import 'package:petilla_app_project/view/user/start/view/select_app_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
      bottomNavigationBar: const AdWidgetBanner(),
    );
  }

  AppBar _appBar(context) {
    return AppBar(
      title: Text(_ThisPageTexts.title),
      leading: _backIcon(context),
      actions: [settingsIcon(context), smallWidthSizedBox],
    );
  }

  GestureDetector _backIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SelectAppView()),
          (route) => false,
        );
      },
      child: const Icon(AppIcons.arrowBackIcon),
    );
  }

  GestureDetector settingsIcon(context) {
    return GestureDetector(
      onTap: () {
        _settingBottomSheet(context);
      },
      child: SvgPicture.asset(Assets.svg.settings),
    );
  }

  Future<dynamic> _settingBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36), topRight: Radius.circular(36)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _listTile(
                  context, AppIcons.info, LocaleKeys.about, const AboutView()),
              _listTile(
                  context, AppIcons.feed, LocaleKeys.feedBack, FeedBackView()),
              _listTile(context, AppIcons.link, LocaleKeys.links,
                  const SocialConnectionView()),
              _logOutButton(),
              _deleteAccountButton(),
            ],
          ),
        );
      },
    );
  }

  Padding _logOutButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            setState(() {
              viewModel.logOut();
            });
          });
        },
        child: Text(
          LocaleKeys.auth_logout.locale,
          style: const TextStyle(
            color: LightThemeColors.red,
          ),
        ),
      ),
    );
  }

  Padding _deleteAccountButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DeleteAccountConfirmView(),
            ),
          );
        },
        child: Text(
          LocaleKeys.auth_deleteAccount.locale,
          style: const TextStyle(
            color: LightThemeColors.red,
          ),
        ),
      ),
    );
  }

  ListTile _listTile(
      BuildContext context, IconData icon, String text, Widget route) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32,
        color: LightThemeColors.black,
      ),
      title: Text(
        text.locale,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
    );
  }

  SafeArea _streamBodyBuilder() {
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection(AppFirestoreCollectionNames.usersCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _hasDataScreen(snapshot, context);
          }
          if (snapshot.hasError) {
            return _errorLottie;
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return _connectionErrorLottie;
          }
          return _loadingLottie;
        },
      ),
    );
  }

  StatusView get _loadingLottie =>
      const StatusView(status: StatusKeysEnum.LOADING);

  StatusView get _errorLottie => const StatusView(status: StatusKeysEnum.ERROR);

  StatusView get _connectionErrorLottie =>
      const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  SingleChildScrollView _hasDataScreen(snapshot, context) {
    String name = FirebaseAuth.instance.currentUser!.displayName!;
    String email = FirebaseAuth.instance.currentUser!.email!  ;
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
