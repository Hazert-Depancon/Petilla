import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class DeclarationView extends StatefulWidget {
  const DeclarationView({Key? key}) : super(key: key);

  @override
  State<DeclarationView> createState() => DdeclarationStateView();
}

class DdeclarationStateView extends State<DeclarationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İlanlarım"),
        foregroundColor: LightThemeColors.miamiMarmalade,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
