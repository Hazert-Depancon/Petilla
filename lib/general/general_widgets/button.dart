import 'package:flutter/material.dart';
import 'package:petilla_app_project/constant/sizes/project_radius.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.onPressed, this.width, this.height, this.text, this.noBorderRadius})
      : super(key: key);

  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final String? text;
  final bool? noBorderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: ProjectRadius.buttonAllRadius,
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: LightThemeColors.miamiMarmalade,
          borderRadius: noBorderRadius == null ? ProjectRadius.buttonAllRadius : null,
        ),
        child: Center(
            child: Text(
          text ?? "",
          style: Theme.of(context).textTheme.button,
        )),
      ),
    );
  }
}
