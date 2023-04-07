import 'package:flutter/material.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:kartal/kartal.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: context.normalBorderRadius,
      child: Container(
        width: context.width / 1.8,
        height: context.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          gradient: const LinearGradient(
            colors: [
              LightThemeColors.miamiMarmalade,
              LightThemeColors.pastelStrawberry,
            ],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
