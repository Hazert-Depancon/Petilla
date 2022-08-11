import 'package:flutter/material.dart';
import 'package:petilla_app_project/general_widgets/ads/ads_widget.dart';
import 'package:petilla_app_project/general_widgets/select_app_widget.dart';
import 'package:petilla_app_project/main_petilla/view/main_view/profile_view.dart';
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
        title: const Text('Petilla'),
        centerTitle: true,
        actions: [
          _profileAction(context),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: ProjectPaddings.horizontalMainPadding,
              child: _haveAPetText(),
            ),
            const SizedBox(height: 24),
            _adsWidget(),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: const [
                      SizedBox(width: 16),
                      SelectAppWidget(isBig: false, title: 'Petform', imagePath: "assets/images/form_site_image.png"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _haveAPetText() {
    return const Text(
      "Evcil hayvanınız mı var? Burası tam sana göre! Haydi hemen başla.",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  _adsWidget() {
    return const AdsWidget(
      images: [
        // Reklamları buraya ekle
        'assets/images/REKLAM.png',
        "assets/images/reklam1.png",
        "assets/images/onboarding_one.png",
      ],
      titles: [
        // Sıra sıra başlıkları buraya ekle
        "Reklam 1",
        "Reklam 2",
        "Reklam 3",
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
  static const String haveAPetText = "Evcil hayvanınız mı var? Burası tam sana göre! Haydi hemen başla.";
}
