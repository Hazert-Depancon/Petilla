import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPressed,
    this.text,
    this.noBorderRadius,
    this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String? text;
  final bool? noBorderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.normalBorderRadius,
      onTap: onPressed,
      child: Container(
        width: context.width / 2,
        height: context.height * 0.08,
        decoration: _boxDecoration(context),
        child: Center(
          child: _text(context),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: color ?? LightThemeColors.miamiMarmalade,
      borderRadius: noBorderRadius == null ? context.normalBorderRadius : null,
    );
  }

  Text _text(BuildContext context) {
    return Text(
      text ?? "",
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
