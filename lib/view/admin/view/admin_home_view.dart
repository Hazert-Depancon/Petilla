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
import 'package:petilla_app_project/view/user/apps/main_petilla/core/components/pet_widgets/large_pet_widget.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/models/pet_model.dart';

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

  DefaultTabController get _buildScaffold => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar,
          body: _body(),
        ),
      );

  AppBar get _appBar {
    return AppBar(
      title: Text(LocaleKeys.reportedAnimals.locale),
      bottom: const TabBar(
        tabs: <Widget>[
          Tab(
            text: "Bildirilen Hayvanlar",
          ),
          Tab(
            text: "Bildirilen İlanlar",
          ),
        ],
      ),
    );
  }

  TabBarView _body() {
    return TabBarView(
      children: <Widget>[
        reportedAnimals(),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.reportedInserts).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: ProjectPaddings.horizontalMainPadding,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection(AppFirestoreCollectionNames.petsCollection)
                        .doc(snapshot.data!.docs[index].id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _largePetWidget(snapshot);
                      }
                      return const StatusView(status: StatusKeysEnum.LOADING);
                    },
                  );
                },
              );
            }
            return const StatusView(status: StatusKeysEnum.LOADING);
          },
        ),
      ],
    );
  }

  LargePetWidget _largePetWidget(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    return LargePetWidget(
      petModel: _petModel(snapshot.data),
      isMe: true,
    );
  }

  PetModel _petModel(document) {
    return PetModel(
      currentUserName: document[AppFirestoreFieldNames.currentNameField],
      currentUid: document[AppFirestoreFieldNames.currentUidField],
      currentEmail: document[AppFirestoreFieldNames.currentEmailField],
      ilce: document[AppFirestoreFieldNames.ilceField],
      gender: document[AppFirestoreFieldNames.genderField],
      name: document[AppFirestoreFieldNames.nameField],
      description: document[AppFirestoreFieldNames.descriptionField],
      imagePath: document[AppFirestoreFieldNames.imagePathField],
      ageRange: document[AppFirestoreFieldNames.ageRangeField],
      city: document[AppFirestoreFieldNames.cityField],
      petBreed: document[AppFirestoreFieldNames.petBreedField],
      price: document[AppFirestoreFieldNames.priceField],
      petType: document[AppFirestoreFieldNames.petTypeField],
      docId: document.id,
    );
  }

  StreamBuilder<QuerySnapshot> reportedAnimals() {
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
      petModel: _reportedAnimalModel(snapshot, index),
    );
  }

  ReportedPetModel _reportedAnimalModel(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
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
