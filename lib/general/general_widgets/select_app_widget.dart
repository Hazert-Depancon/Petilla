import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class SelectAppWidget extends StatelessWidget {
  const SelectAppWidget(
      {Key? key, this.isBig = false, required this.title, required this.imagePath, required this.onTap})
      : super(key: key);
  final bool isBig;
  final String title;
  final String imagePath;
  final Widget onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onTap));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: isBig ? 220 : 105,
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
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: LightThemeColors.burningOrange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
