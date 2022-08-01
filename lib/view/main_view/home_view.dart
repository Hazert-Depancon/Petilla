import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/service/models/pet_model.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';
import 'package:petilla_app_project/view/widgets/pet_widgets/normal_pet_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget buildPet(PetModel pet) => NormalPetWidget(
        name: pet.name,
        ageRange: pet.ageRange,
        breed: pet.petBreed,
        imagePath: pet.imagePath,
        description: pet.description,
        location: pet.location,
        price: pet.price,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ThisPageTexts.homePage),
      ),
      body: Center(
        child: Padding(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Column(
            children: [
              searchTextField(),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<List<PetModel>>(
                    stream: readPets(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
                      } else if (snapshot.hasData) {
                        final pets = snapshot.data!;
                        return GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.95,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                          ),
                          children: pets.map(buildPet).toList(),
                        );
                      }
                      return Lottie.network(ProjectLottieUrls.loadingLottie);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView _myPetGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return const NormalPetWidget(
          ageRange: "ageRange",
          breed: "Kedi",
          description: "Kedi",
          imagePath: "assets/images/rifki.jpg",
          location: "İstanbul",
          name: "Kedi",
          price: "0",
        );
      },
    );
  }

  Stream<List<PetModel>> readPets() => FirebaseFirestore.instance.collection("pets").snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => PetModel.fromJson(doc.data())).toList(),
      );

  Container searchTextField() {
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
