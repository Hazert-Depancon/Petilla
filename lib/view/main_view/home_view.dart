import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/view/theme/strings/project_lottie_urls.dart';
import 'package:petilla_app_project/view/widgets/pet_widgets/normal_pet_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('pets').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: _myGridDelegate(),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document = snapshot.data!.docs[index];
                          return NormalPetWidget(
                            // sex: document["sex"],
                            sex: "Erkek",
                            petType: document["petType"],
                            name: document["name"],
                            ageRange: document["ageRange"],
                            petBreed: document["petBreed"],
                            imagePath: document["imagePath"],
                            description: document["description"],
                            location: document["location"],
                            price: document["price"],
                          );
                        },
                      );
                    }
                    return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _myGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      crossAxisSpacing: 12,
      mainAxisSpacing: 16,
    );
  }

  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //   crossAxisCount: 2,
  //   childAspectRatio: 0.95,
  //   crossAxisSpacing: 12,
  //   mainAxisSpacing: 16,
  // ),

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
