import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/admin/core/models/reported_pet_model.dart';
import 'package:petilla_app_project/view/admin/view/reported_pet_detail_view.dart';

class ReportedPetWidget extends StatefulWidget {
  const ReportedPetWidget({super.key, required this.petModel});
  final ReportedPetModel petModel;

  @override
  State<ReportedPetWidget> createState() => _ReportedPetWidgetState();
}

class _ReportedPetWidgetState extends State<ReportedPetWidget> {
  String noImage = "https://ispark.istanbul/wp-content/themes/ispark2019/images/gorselyok.png";

  var smallHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportedPetDetailView(
              petModel: widget.petModel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: LightThemeColors.snowbank,
            borderRadius: ProjectRadius.mainAllRadius,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageContainer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  smallHeightSizedBox,
                  Text(widget.petModel.description),
                  smallHeightSizedBox,
                  Text(widget.petModel.phoneNumber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _imageContainer() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
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
    );
  }
}
