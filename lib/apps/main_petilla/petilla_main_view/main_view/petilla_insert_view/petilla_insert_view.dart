import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/core/components/pet_widgets/large_pet_widget.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/constant/string_constant/project_lottie_urls.dart';

class PetillaInsertView extends StatelessWidget {
  const PetillaInsertView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_ThisPageTexts.myInserts),
      automaticallyImplyLeading: false,
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _body() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.petsCollection)
          .where(
            AppFirestoreFieldNames.currentUidField,
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
            return _notPetYet(context);
          }

          return _inserts(snapshot);
        }
        if (snapshot.hasError) {
          return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
        }

        return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
      },
    );
  }

  ListView _inserts(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      padding: ProjectPaddings.horizontalMainPadding,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _petWidget(snapshot.data!.docs[index]);
      },
    );
  }
}

Center _notPetYet(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _ThisPageTexts.notInsertYet,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Lottie.network(ProjectLottieUrls.emptyLottie),
      ],
    ),
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

class _ThisPageTexts {
  static String myInserts = "İlanlarım";
  static String notInsertYet = "Henüz Hiç İlanınız Yok";
}
