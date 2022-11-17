// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/core/components/pet_widgets/large_pet_widget.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/core/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constant/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constant/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/constant/string_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/core/constant/string_constant/shared_preferences_key_constants.dart';
import 'package:petilla_app_project/core/extension/string_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({super.key});

  int? listLenght = 0;

  List? myList;

  List<String> list = [];

  _getShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myList = preferences.getStringList(SharedPreferencesKeyConstants.favsConstant) ?? [];
    listLenght = myList?.length ?? 0;

    for (var i = 0; i < listLenght!; i++) {
      list.add(myList![i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  FutureBuilder<Object?> _body() {
    return FutureBuilder(
      future: _getShared(),
      builder: (context, snapshot) {
        if (myList?.isNotEmpty ?? false) {
          return _listView();
        }
        if (myList?.isEmpty ?? true) {
          return _emptyLottie();
        }

        return _loadingLottie();
      },
    );
  }

  Center _emptyLottie() {
    return Center(
      child: Lottie.network(ProjectLottieUrls.emptyLottie),
    );
  }

  Center _loadingLottie() {
    return Center(
      child: Lottie.network(ProjectLottieUrls.loadingLottie),
    );
  }

  ListView _listView() {
    return ListView.builder(
      padding: ProjectPaddings.horizontalMainPadding,
      itemCount: listLenght,
      itemBuilder: (context, index) {
        return _streamBuilder(index);
      },
    );
  }

  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> _streamBuilder(int index) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.petsCollection)
          .doc(myList![index])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists == true) {
          return _largePetWidget(snapshot);
        }
        if (snapshot.data?.exists == false) {
          // Todo
          return const Text("Favoriler listenizdeki bu ilan kaldırıldı.");
        }

        return _loadingLottie();
      },
    );
  }

  LargePetWidget _largePetWidget(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    return LargePetWidget(
      petModel: _petModel(snapshot.data),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.myFavorites.locale),
      automaticallyImplyLeading: false,
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
