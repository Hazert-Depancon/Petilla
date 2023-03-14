// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/components/banner_ad_widget.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/components/question_form_model_mini.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/constants/animal_types.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/models/question_form_model.dart';
import 'package:petilla_app_project/view/user/apps/petform/viewmodel/petform_home_view_model.dart';

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
        floatingActionButton: _addQuestion(context),
        bottomNavigationBar: const AdWidgetBanner(),
      );

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        // stream: viewModel.stream.snapshots(),
        stream: FirebaseFirestore.instance
            .collection(AppFirestoreCollectionNames.petform)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView(
                children: [
                  QuestionFormModelMini(
                    formModel: QuestionFormModel(
                      upCount: 1,
                      animalType: AnimalTypes().rabbit,
                      title: "Test",
                      description: "Test açıklaması",
                      currentUserName:
                          FirebaseAuth.instance.currentUser!.displayName!,
                      currentUid: FirebaseAuth.instance.currentUser!.uid,
                      currentEmail: FirebaseAuth.instance.currentUser!.email!,
                      createdTime: DateTime.now(),
                    ),
                  ),
                ],
              );
            }
            return const StatusView(status: StatusKeysEnum.EMPTY);
          }
          if (snapshot.hasError) {}
          return const StatusView(status: StatusKeysEnum.LOADING);
        },
      ),
    );
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

  FloatingActionButton _addQuestion(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.question_mark_rounded),
    );
  }
}

class _ThisPageTexts {
  static String selectGroup = LocaleKeys.selectAGroup.locale;
}
