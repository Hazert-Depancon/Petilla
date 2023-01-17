import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: ProjectRadius.buttonAllRadius,
      child: Container(
        width: ProjectButtonSizes.mainButtonWidth,
        height: ProjectButtonSizes.mainButtonHeight,
        decoration: BoxDecoration(
          borderRadius: ProjectRadius.buttonAllRadius,
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
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
