import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/service/models/hive_data.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/widgets/pet_widgets/large_pet_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final List<Fav> favorites = [];
  @override
  void dispose() {
    // Hive.box<Fav>("favorites").close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: LightThemeColors.scaffoldBackgroundColor,
        title: const Text(_ThisPageTexts.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          return _listView(snapshot);
        },
      ),
    );
  }

  ListView _listView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      // itemCount: snapshot.data!.docs.length,
      padding: ProjectPaddings.horizontalMainPadding,
      itemBuilder: (context, index) {
        return _petWidget(snapshot, index);
      },
    );
  }

  LargePetWidget _petWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return const LargePetWidget(
      ilce: "ilce",
      sex: "sex",
      name: "name",
      description: "description",
      imagePath: "imagePath",
      ageRange: "ageRange",
      city: "city",
      petBreed: "petBreed",
      price: "price",
      petType: "petType",
    );
  }

  // Center _noFavoritesYet() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _noFavoritesYetText(),
  //         Lottie.network(ProjectLottieUrls.emptyLottie),
  //       ],
  //     ),
  //   );
  // }

  // Text _noFavoritesYetText() {
  //   return const Text(
  //     "Henüz Hiç Favori Hayvanınız Yok",
  //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  //   );
  // }
}

class _ThisPageTexts {
  static const String title = "Favorilerim";
}
