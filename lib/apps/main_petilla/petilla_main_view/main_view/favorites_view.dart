import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: LightThemeColors.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: const Text(_ThisPageTexts.title),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection("users_favs")
      //       .doc(FirebaseAuth.instance.currentUser!.email)
      //       .collection("pets")
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data!.docs.isEmpty) {
      //         return Center(
      //           child: Column(
      //             children: [
      //               const SizedBox(height: 120),
      //               const Text("Henüz hiç favori hayvanınız yok", style: TextStyle(fontSize: 20)),
      //               Center(child: Lottie.network(ProjectLottieUrls.emptyLottie)),
      //             ],
      //           ),
      //         );
      //       }
      //       return ListView.builder(
      //         padding: ProjectPaddings.horizontalMainPadding,
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (context, index) {
      //           final DocumentSnapshot document = snapshot.data!.docs[index];
      //           return LargePetWidget(
      //             sex: document["sex"],
      //             name: document["name"],
      //             ageRange: document["ageRange"],
      //             petBreed: document["petBreed"],
      //             imagePath: document["imagePath"],
      //             description: document["description"],
      //             city: document["city"],
      //             price: document["price"],
      //             petType: document["petType"],
      //             ilce: document["ilce"],
      //             friendUId: document["friendUId"],
      //             friendEmail: document["friendEmail"],
      //           );
      //         },
      //       );
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
      //     }
      //     return ListView.builder(
      //       itemBuilder: (context, index) {
      //         final DocumentSnapshot document = snapshot.data!.docs[index];
      //         return NormalPetWidget(
      //           isFav: document["isFav"],
      //           sex: document["sex"],
      //           name: document["name"],
      //           ageRange: document["ageRange"],
      //           petBreed: document["petBreed"],
      //           imagePath: document["imagePath"],
      //           description: document["description"],
      //           city: document["city"],
      //           price: document["price"],
      //           petType: document["petType"],
      //           ilce: document["ilce"],
      //           friendUId: document["friendUId"],
      //           friendEmail: document["friendEmail"],
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

class _ThisPageTexts {
  static const String title = "Favorilerim";
}
