import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

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
    );
  }
}

class _ThisPageTexts {
  static const String title = "Favorilerim";
}
