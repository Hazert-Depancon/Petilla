import 'package:flutter/material.dart';
import 'package:patily/core/constants/sizes_constant/project_radius.dart';
import 'package:patily/core/init/theme/light_theme/light_theme_colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPressed,
    this.width,
    this.height,
    this.text,
    this.noBorderRadius,
    this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final String? text;
  final bool? noBorderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: ProjectRadius.buttonAllRadius,
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: _boxDecoration(),
        child: Center(
          child: _text(context),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: color ?? LightThemeColors.miamiMarmalade,
      borderRadius:
          noBorderRadius == null ? ProjectRadius.buttonAllRadius : null,
    );
  }

  Text _text(BuildContext context) {
    return Text(
      text ?? "",
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
