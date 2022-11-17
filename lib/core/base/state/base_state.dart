import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => LightTheme().theme;
  LightThemeColors get lightThemeColors => LightThemeColors();
}
