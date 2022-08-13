import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/pet_form/main_pet_form.dart';
import 'package:petilla_app_project/apps/pet_media/main_pet_media.dart';
import 'package:petilla_app_project/general/general_view/profile_view.dart';
import 'package:petilla_app_project/general/general_widgets/ads/ads_widget.dart';
import 'package:petilla_app_project/general/general_widgets/select_app_widget.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';

class SelectAppView extends StatefulWidget {
  const SelectAppView({Key? key}) : super(key: key);

  @override
  State<SelectAppView> createState() => _SelectAppViewState();
}

class _SelectAppViewState extends State<SelectAppView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _profileAction(context),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 12),
            const SizedBox(height: 24),
            _adsWidget(),
            const SizedBox(height: 8),
            Padding(
              padding: ProjectPaddings.horizontalMainPadding,
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: _selectPetilla(),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1.5,
                    child: _selectPetform(),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: _selectPetmedia(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SelectAppWidget _selectPetmedia() {
    return const SelectAppWidget(
      isBig: true,
      title: 'Petmedia',
      imagePath: "assets/images/social_pet.png",
      onTap: MainPetMedia(),
    );
  }

  SelectAppWidget _selectPetform() {
    return const SelectAppWidget(
      title: 'Petform',
      imagePath: "assets/images/petform.png",
      onTap: MainPetForm(),
    );
  }

  SelectAppWidget _selectPetilla() {
    return const SelectAppWidget(
      isBig: true,
      title: 'Petilla',
      imagePath: "assets/images/petilla_image.png",
      onTap: MainPetilla(),
    );
  }

  _adsWidget() {
    return const AdsWidget(
      images: [
        // Reklamları buraya ekle
        'assets/images/REKLAM.png',
        "assets/images/reklam1.png",
        "assets/images/petform.png",
      ],
      titles: [
        // Sıra sıra başlıkları buraya ekle
        "Reklam 1",
        "Reklam 2",
        "Reklam 3",
      ],
      descriptions: [
        // Sıra sıra açıklamaları buraya ekle
        "Reklam 1 açıklaması",
        "Reklam 2 açıklaması",
        "Reklam 3 açıklaması",
      ],
      urls: [
        // Sıra sıra urlleri buraya ekle
        "https://pub.dev/packages/url_launcher",
        "https://pub.dev/packages/url_launcher",
        "https://pub.dev/packages/url_launcher",
      ],
    );
  }

  GestureDetector _profileAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _callProfileView(context);
      },
      child: const Icon(Icons.person_outline),
    );
  }

  void _callProfileView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileView()));
  }
}

class ThisPageTexts {
  static const String title = "Petilla";
}
