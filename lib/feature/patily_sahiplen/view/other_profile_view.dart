// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/widgets/patily_sahiplen/pet_widgets/large_pet_widget.dart';
import 'package:patily/product/models/patily_sahiplen/pet_model.dart';
import 'package:patily/feature/patily_sahiplen/viewmodel/other_profile_view_view_model.dart';

class OtherProfileView extends StatelessWidget {
  OtherProfileView({super.key, required this.petModel});

  final PetModel petModel;

  late OtherProfileViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<OtherProfileViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: OtherProfileViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold,
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        appBar: _appBar,
        body: _streamBuilder,
      );

  AppBar get _appBar {
    return AppBar(
      title: Text(petModel.currentUserName),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> get _streamBuilder {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseCollectionEnum.pets.reference
          .where(AppFirestoreFieldNames.currentUidField,
              isEqualTo: petModel.currentUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
            return _notPetYet;
          }

          return _inserts(snapshot, context);
        }
        if (snapshot.hasError) {
          return _errorLottie;
        }

        return _loadingLottie;
      },
    );
  }

  ListView _inserts(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    return ListView.builder(
      padding: context.horizontalPaddingNormal,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _petWidget(snapshot.data!.docs[index]);
      },
    );
  }

  LargePetWidget _petWidget(document) {
    return LargePetWidget(
      petModel: _petModel(document),
    );
  }

  PetModel _petModel(DocumentSnapshot<Object?> document) {
    return PetModel(
      currentUid: document[AppFirestoreFieldNames.currentUidField],
      currentUserName: document[AppFirestoreFieldNames.currentNameField],
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

  StatusView get _loadingLottie =>
      const StatusView(status: StatusKeysEnum.LOADING);
  StatusView get _errorLottie => const StatusView(status: StatusKeysEnum.ERROR);
  StatusView get _notPetYet => const StatusView(status: StatusKeysEnum.EMPTY);
}
