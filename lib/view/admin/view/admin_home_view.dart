// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/view/admin/core/components/reported_pet_widget.dart';
import 'package:petilla_app_project/view/admin/core/models/reported_pet_model.dart';
import 'package:petilla_app_project/view/admin/viewmodel/admin_home_view_view_model.dart';

class AdminHomeView extends StatelessWidget {
  AdminHomeView({super.key});

  late AdminHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: AdminHomeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold,
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        appBar: _appBar,
        body: _body(),
      );

  AppBar get _appBar {
    return AppBar(
      title: Text(LocaleKeys.reportedAnimals.locale),
    );
  }

  StreamBuilder<QuerySnapshot> _body() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.reportAnimalCollection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _listView(snapshot);
        }
        return _loadingLottie;
      },
    );
  }

  ListView _listView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      padding: ProjectPaddings.horizontalMainPadding,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _reportedPetWidget(snapshot, index);
      },
    );
  }

  ReportedPetWidget _reportedPetWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return ReportedPetWidget(
      petModel: _petModel(snapshot, index),
    );
  }

  ReportedPetModel _petModel(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return ReportedPetModel(
      imagePath: snapshot.data!.docs[index][AppFirestoreFieldNames.imagePathField],
      description: snapshot.data!.docs[index][AppFirestoreFieldNames.descriptionField],
      phoneNumber: snapshot.data!.docs[index][AppFirestoreFieldNames.phoneNumberField],
      long: snapshot.data!.docs[index][AppFirestoreFieldNames.long],
      currentEmail: snapshot.data!.docs[index][AppFirestoreFieldNames.currentEmailField],
      currentUid: snapshot.data!.docs[index][AppFirestoreFieldNames.currentUidField],
      currentName: snapshot.data!.docs[index][AppFirestoreFieldNames.currentNameField],
      lat: snapshot.data!.docs[index][AppFirestoreFieldNames.lat],
      isDamaged: snapshot.data!.docs[index][AppFirestoreFieldNames.isDamaged],
    );
  }

  StatusView get _loadingLottie => const StatusView(status: StatusKeysEnum.LOADING);
}
