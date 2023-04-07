// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/widgets/patily_sahiplen/pet_widgets/large_pet_widget.dart';
import 'package:patily/product/models/patily_sahiplen/pet_model.dart';
import 'package:patily/feature/patily_sahiplen/viewmodel/favorites_view_view_model.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({super.key});

  late FavoritesViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<FavoritesViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: FavoritesViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
        appBar: _appBar,
        body: _body(context),
      );

  AppBar get _appBar => AppBar(
        title: Text(LocaleKeys.patilySahiplenPages_myFavorites.locale),
        automaticallyImplyLeading: false,
      );

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Observer(builder: (_) {
        return FutureBuilder(
          future: viewModel.getShared(),
          builder: (context, snapshot) {
            if (viewModel.myList?.isNotEmpty ?? false) {
              return _listView(context);
            }
            if (viewModel.myList?.isEmpty ?? true) {
              return _emptyLottie;
            }

            return _loadingLottie;
          },
        );
      }),
    );
  }

  Observer _listView(BuildContext context) {
    return Observer(builder: (_) {
      return ListView.builder(
        padding: context.horizontalPaddingNormal,
        itemCount: viewModel.listLenght!,
        itemBuilder: (context, index) {
          return _streamBuilder(index);
        },
      );
    });
  }

  Observer _streamBuilder(int index) {
    return Observer(builder: (_) {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseCollectionEnum.pets.toString())
            .doc(viewModel.myList![index])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists == true) {
            return _largePetWidget(snapshot);
          }
          if (snapshot.data?.exists == false) {
            return Text(LocaleKeys.notFavYet.locale);
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return _connectionErrorView;
          }

          return _loadingLottie;
        },
      );
    });
  }

  StatusView get _connectionErrorView =>
      const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  StatusView get _emptyLottie => const StatusView(status: StatusKeysEnum.EMPTY);

  StatusView get _loadingLottie =>
      const StatusView(status: StatusKeysEnum.LOADING);

  LargePetWidget _largePetWidget(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    return LargePetWidget(
      petModel: _petModel(snapshot.data),
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
}
