import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/widgets/pet_widgets/normal_pet_widget.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class PetillaHomeView extends StatefulWidget {
  const PetillaHomeView({Key? key}) : super(key: key);

  @override
  State<PetillaHomeView> createState() => _PetillaHomeViewState();
}

class _PetillaHomeViewState extends State<PetillaHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ThisPageTexts.homePage),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: ProjectPaddings.horizontalMainPadding,
              itemCount: snapshot.data!.docs.length,
              gridDelegate: _myGridDelegate(),
              itemBuilder: (context, index) {
                return _petWidget(snapshot.data!.docs[index]);
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

  NormalPetWidget _petWidget(document) {
    return NormalPetWidget(
      petModel: _petModel(document),
    );
  }

  PetModel _petModel(DocumentSnapshot<Object?> document) {
    return PetModel(
      currentUid: document["currentUid"],
      currentEmail: document["currentEmail"],
      ilce: document["ilce"],
      gender: document["gender"],
      name: document["name"],
      description: document["description"],
      imagePath: document["imagePath"],
      ageRange: document["ageRange"],
      city: document["city"],
      petBreed: document["petBreed"],
      price: document["price"],
      petType: document["petType"],
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _myGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 200,
      crossAxisSpacing: 12,
      mainAxisSpacing: 16,
    );
  }

  searchTextField() {
    return Container(
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: ProjectRadius.mainAllRadius,
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: _ThisPageTexts.search,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class _ThisPageTexts {
  static const String homePage = "Anasayfa";
  static const String search = "Favori hayvanlarınızı arayın";
}
