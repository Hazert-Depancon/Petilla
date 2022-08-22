import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/widgets/pet_widgets/normal_pet_widget.dart';
import 'package:petilla_app_project/start/select_app_view.dart';
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
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ThisPageTexts.homePage),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => const SelectAppView()), (route) => false);
            },
            child: SvgPicture.asset(
              "assets/svg/home_outline.svg",
              color: LightThemeColors.miamiMarmalade,
              height: 32,
            ),
          ),
          const SizedBox(width: 16),
        ],
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: ProjectPaddings.horizontalMainPadding,
              child: searchTextField(),
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('pets').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(child: _gridView(snapshot));
                }
                if (snapshot.hasError) {
                  return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
                }

                return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
              },
            ),
          ],
        ),
      ),
    );
  }

  _gridView(snapshot) {
    return search == ""
        ? GridView.builder(
            padding: ProjectPaddings.horizontalMainPadding,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: _myGridDelegate(),
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              return _petWidget(document);
            },
          )
        : GridView.builder(
            padding: ProjectPaddings.horizontalMainPadding,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: _myGridDelegate(),
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              if (document["petType"].toString().toLowerCase().contains(search.toLowerCase()) ||
                  document["name"].toString().toLowerCase().contains(search.toLowerCase())) {
                return _petWidget(document);
              }
              return Container();
            },
          );
  }

  NormalPetWidget _petWidget(DocumentSnapshot<Object?> document) {
    return NormalPetWidget(
      petModel: _petModel(document),
    );
  }

  PetModel _petModel(DocumentSnapshot<Object?> document) {
    return PetModel(
      currentUid: document["currentUid"],
      currentEmail: document["currentEmail"],
      ilce: document["ilce"],
      sex: document["sex"],
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

  Container searchTextField() {
    return Container(
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: ProjectRadius.mainAllRadius,
      ),
      child: TextField(
        onChanged: (val) {
          setState(() {
            search = val;
          });
        },
        decoration: const InputDecoration(
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
