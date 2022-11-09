import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/petilla_main_widgets/pet_widgets/large_pet_widget.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  int? listLenght;
  List? myList;
  String? id;

  _getShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myList = preferences.getStringList("favs") ?? [];
    listLenght = myList?.length ?? 0;

    for (var i = 0; i < listLenght!; i++) {
      id = myList![i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder(
        future: _getShared(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("pets").doc(myList![0]).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    padding: ProjectPaddings.horizontalMainPadding,
                    itemBuilder: (context, index) {
                      return LargePetWidget(petModel: _petModel(snapshot.data));
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: ProjectPaddings.horizontalMainPadding,
            itemBuilder: (context, index) {
              return LargePetWidget(petModel: _petModel(snapshot.data));
            },
          );
        },
      ),
    );
  }

  // LargePetWidget _largePetWidget(document) {
  //   return LargePetWidget(
  //     petModel: _petModel(document),
  //   );
  // }

  AppBar _appBar() {
    return AppBar(
      title: Text(Localization.myFavorites),
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
