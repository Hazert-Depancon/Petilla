// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/core/components/banner_ad_widget.dart';
import 'package:patily/core/constants/enums/status_keys_enum.dart';
import 'package:patily/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:patily/core/extension/string_lang_extension.dart';
import 'package:patily/core/init/lang/locale_keys.g.dart';
import 'package:patily/core/constants/other_constant/icon_names.dart';
import 'package:patily/view/user/apps/patiform/core/components/question_form_widget_mini.dart';
import 'package:patily/view/user/apps/patiform/core/models/question_form_model.dart';
import 'package:patily/view/user/apps/patiform/viewmodel/patiform_home_view_model.dart';

class PatiformHomeView extends StatelessWidget {
  PatiformHomeView({Key? key}) : super(key: key);

  late PatiformHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<PatiformHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: PatiformHomeViewViewModel(),
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
            .collection(AppFirestoreCollectionNames.patiform)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return QuestionFormModelMini(
                    formModel: QuestionFormModel(
                      animalType: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.animalType],
                      title: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.title],
                      description: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.descriptionField],
                      currentUserName: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.currentNameField],
                      currentUid: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.currentUidField],
                      currentEmail: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.currentEmailField],
                      createdTime: snapshot.data!.docs[index]
                          [AppFirestoreFieldNames.createdTimeField],
                      docId: snapshot.data!.docs[index].id,
                    ),
                  );
                },
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
      title: Text(LocaleKeys.questions.locale),
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
      onPressed: () {
        viewModel.callAddQuestionView();
      },
      child: const Icon(Icons.question_mark_rounded),
    );
  }
}
