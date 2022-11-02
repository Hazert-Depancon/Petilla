import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/petilla_main_widgets/pet_widgets/large_pet_widget.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late String docId;

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List myList = preferences.getStringList("favs")!.toList();

    for (var i = 0; i < preferences.getStringList("favs")!.length; i++) {
      return myList[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("pets").doc(getData()).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return _notPetYet(context);
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return _largePetWidget(snapshot.data);
              },
            );
          }
          if (snapshot.hasError) {
            return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
          }

          return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
        },
      ),
    );
  }

  LargePetWidget _largePetWidget(document) => LargePetWidget(petModel: _petModel(document));

  Center _notPetYet(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Evcil Hayvan Yok",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Lottie.network(ProjectLottieUrls.emptyLottie),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(Localization.myFavorites),
      automaticallyImplyLeading: false,
    );
  }

  PetModel _petModel(DocumentSnapshot<Object?> document) {
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
