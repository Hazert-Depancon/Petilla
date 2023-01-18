import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class SelectAppWidget extends StatelessWidget {
  const SelectAppWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String description;
  final String imagePath;
  final Widget onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => onTap),
          (route) => false,
        );
      },
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightThemeColors.white,
          borderRadius: ProjectRadius.allRadius,
          boxShadow: const [
            BoxShadow(
              color: LightThemeColors.shadowColor,
              offset: Offset(10, 10),
              blurRadius: 30,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: LightThemeColors.white,
              offset: Offset(-10, -10),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(flex: 4, child: SizedBox(height: 200, width: 200, child: Image.asset(imagePath)))
            ],
          ),
        ),
      ),
    );
  }
}
