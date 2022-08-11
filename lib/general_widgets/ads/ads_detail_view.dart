import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';

class AdsDetailView extends StatefulWidget {
  const AdsDetailView({Key? key, required this.image, required this.title}) : super(key: key);

  final String image;
  final String title;

  @override
  State<AdsDetailView> createState() => _AdsDetailViewState();
}

class _AdsDetailViewState extends State<AdsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(widget.image),
          ],
        ),
      ),
    );
  }
}
