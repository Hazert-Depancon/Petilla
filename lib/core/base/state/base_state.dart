import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => LightTheme().theme;
  TextTheme get textTheme => LightTheme().theme.textTheme;
}
