// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/google_ads/ads_state.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/core/components/pet_widgets/large_pet_widget.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/models/pet_model.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/viewmodel/favorites_view_view_model.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({super.key});

  late FavoritesViewViewModel viewModel;

  BannerAd? _banner;

  void _createBannerAd() {
    _banner = AdmobManager().createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FavoritesViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        _createBannerAd();
      },
      viewModel: FavoritesViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold,
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        appBar: _appBar,
        body: _body(),
      );

  AppBar get _appBar => AppBar(
        title: Text(LocaleKeys.myFavorites.locale),
        automaticallyImplyLeading: false,
      );

  Observer _body() {
    return Observer(builder: (_) {
      return FutureBuilder(
        future: viewModel.getShared(),
        builder: (context, snapshot) {
          if (viewModel.myList?.isNotEmpty ?? false) {
            return _listView();
          }
          if (viewModel.myList?.isEmpty ?? true) {
            return _emptyLottie;
          }

          return _loadingLottie;
        },
      );
    });
  }

  Observer _listView() {
    return Observer(builder: (_) {
      return ListView.builder(
        padding: ProjectPaddings.horizontalMainPadding,
        itemCount: viewModel.listLenght!,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _adsWidget();
          }
          return _streamBuilder(index);
        },
      );
    });
  }

  Container _adsWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 52,
      child: AdWidget(
        ad: _banner!,
      ),
    );
  }

  Observer _streamBuilder(int index) {
    return Observer(builder: (_) {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(AppFirestoreCollectionNames.petsCollection)
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

  StatusView get _connectionErrorView => const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  StatusView get _emptyLottie => const StatusView(status: StatusKeysEnum.EMPTY);

  StatusView get _loadingLottie => const StatusView(status: StatusKeysEnum.LOADING);

  LargePetWidget _largePetWidget(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
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
