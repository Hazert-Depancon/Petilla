import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.about.locale),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: SingleChildScrollView(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Column(
          children: [
            Text(
              LocaleKeys.aboutOne.locale,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
