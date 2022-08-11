import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';

class SelectAppWidget extends StatelessWidget {
  const SelectAppWidget({Key? key, this.isBig = false, required this.title, required this.imagePath}) : super(key: key);
  final bool isBig;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      height: isBig ? 200 : 125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.6),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(imagePath),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: LightThemeColors.miamiMarmalade,
            ),
          ),
        ),
      ),
    );
  }
}
