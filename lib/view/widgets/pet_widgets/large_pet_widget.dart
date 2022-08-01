import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petilla_app_project/service/models/pet_model.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';

class LargePetWidget extends StatefulWidget {
  const LargePetWidget({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<LargePetWidget> createState() => _LargePetWidgetState();
}

class _LargePetWidgetState extends State<LargePetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      height: 175,
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: ProjectRadius.buttonAllRadius,
      ),
    );
  }
}
