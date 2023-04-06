// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/widgets/banner_ad_widget.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/widgets/patily_form/question_form_widget_mini.dart';
import 'package:patily/product/models/patily_form/question_form_model.dart';
import 'package:patily/feature/patily_form/viewmodel/patily_form_home_view_model.dart';

class PatilyFormHomeView extends StatelessWidget {
  PatilyFormHomeView({Key? key}) : super(key: key);

  late PatilyFormHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<PatilyFormHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: PatilyFormHomeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(context) => Scaffold(
        appBar: _appBar(),
        body: _body(context),
        floatingActionButton: _addQuestion(context),
        bottomNavigationBar: const AdWidgetBanner(),
      );

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: viewModel.stream().snapshots(),
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

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.questions.locale),
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
