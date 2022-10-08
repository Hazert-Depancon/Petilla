import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/main_textfield.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;
  final smallHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _streamBodyBuilder(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      foregroundColor: LightThemeColors.miamiMarmalade,
      title: Text(_ThisPageTexts.title),
      actions: [
        _profileAction(context),
        smallWidthSizedBox,
      ],
    );
  }

  GestureDetector _profileAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AuthService().logout(context);
      },
      child: _exitIcon(),
    );
  }

  Icon _exitIcon() => const Icon(AppIcons.exitAppIcon, color: Colors.black);

  StreamBuilder<DocumentSnapshot> _streamBodyBuilder() {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String name = snapshot.data!['name'].toString();
          String email = snapshot.data!['email'].toString();
          return _hasDataScreen(snapshot, name, email);
        } else {
          return _loadingScreen();
        }
      },
    );
  }

  Center _loadingScreen() {
    return Center(
      child: Lottie.network(ProjectLottieUrls.loadingLottie),
    );
  }

  SingleChildScrollView _hasDataScreen(snapshot, String name, String email) {
    return SingleChildScrollView(
      padding: ProjectPaddings.horizontalMainPadding,
      child: Column(
        children: [
          _circleAvatar(snapshot, name),
          smallHeightSizedBox,
          _nameTextfield(snapshot, name),
          smallHeightSizedBox,
          _emailTextfield(snapshot, email),
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

  CircleAvatar _circleAvatar(snapshot, String name) {
    return CircleAvatar(
      radius: 60,
      child: Center(
        child: Text(
          name.substring(0, 1),
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

class _ThisPageTexts {
  static String title = "profile".tr();
}
