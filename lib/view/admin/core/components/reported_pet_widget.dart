import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/admin/core/models/reported_pet_model.dart';

class ReportedPetWidget extends StatefulWidget {
  const ReportedPetWidget({super.key, required this.petModel});
  final ReportedPetModel petModel;

  @override
  State<ReportedPetWidget> createState() => _ReportedPetWidgetState();
}

class _ReportedPetWidgetState extends State<ReportedPetWidget> {
  String noImage = "https://ispark.istanbul/wp-content/themes/ispark2019/images/gorselyok.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: ProjectRadius.mainAllRadius,
      ),
      child: Row(
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
              borderRadius: ProjectRadius.mainAllRadius,
              color: LightThemeColors.miamiMarmalade,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.petModel.imagePath ?? noImage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
