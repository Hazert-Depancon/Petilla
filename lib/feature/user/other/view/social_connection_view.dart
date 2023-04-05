import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialConnectionView extends StatelessWidget {
  const SocialConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    const String instagramUrl = "https://www.instagram.com/patily.turkiye/";
    const String discordUrl = "https://discord.gg/FEYSuK9sUq";

    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _listTile(context, FontAwesomeIcons.instagram,
                  LocaleKeys.instagram.locale, instagramUrl),
              _listTile(
                context,
                FontAwesomeIcons.discord,
                LocaleKeys.discord.locale,
                discordUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _listTile(BuildContext context, icon, text, url) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: LightThemeColors.black,
        size: 32,
      ),
      onTap: () async {
        await canLaunchUrlString(url)
            ? await launchUrlString(url)
            : throw "ERROR";
      },
      title: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.links.locale),
    );
  }
}
