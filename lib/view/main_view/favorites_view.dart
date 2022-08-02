import 'package:flutter/material.dart';
import 'package:petilla_app_project/service/models/pet_model.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/widgets/pet_widgets/large_pet_widget.dart';

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
        title: const Text(_ThisPageTexts.title),
      ),
      body: Padding(
        padding: ProjectPaddings.horizontalMainPadding,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return LargePetWidget(
              petModel: PetModel(
                sex: "",
                petType: '',
                name: "Rıfkı",
                imagePath: "assets/images/rifki.jpg",
                ageRange: "1-3",
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do",
                location: "İstanbul",
                petBreed: "ırksız",
                price: "150",
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ThisPageTexts {
  static const String title = "Favorilerim";
}
