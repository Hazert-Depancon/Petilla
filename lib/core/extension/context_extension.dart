import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

extension ContextExtension on BuildContext {
  get lightThemeColors => LightThemeColors;
}
