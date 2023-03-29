import 'package:flutter/material.dart';
import 'package:patily/core/constants/sizes_constant/project_padding.dart';
import 'package:patily/core/extension/string_lang_extension.dart';
import 'package:patily/core/init/lang/locale_keys.g.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.about.locale),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Column(
            children: [
              Text(
                LocaleKeys.aboutOne.locale,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
