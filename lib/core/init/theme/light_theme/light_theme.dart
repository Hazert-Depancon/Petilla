import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/core/init/theme/app_theme.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      primarySwatch: Colors.orange,
      primaryColor: LightThemeColors.white,

      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
      brightness: Brightness.light,

      // inputDecoration
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 16),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(20),
      ),

      // Appbar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: LightThemeColors.miamiMarmalade,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightThemeColors.miamiMarmalade,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // CircularProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: LightThemeColors.miamiMarmalade,
      ),

      // Text
      textTheme: const TextTheme(
        button: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        bodyText1: TextStyle(color: LightThemeColors.miamiMarmalade, fontSize: 20),
        subtitle2: TextStyle(fontSize: 16),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: LightThemeColors.miamiMarmalade,
        foregroundColor: Colors.white,
        elevation: 0,
        highlightElevation: 0,
      ),
    );
  }
}

class LightThemes extends AppTheme {
  static LightThemes? _instace;
  static LightThemes get instance {
    _instace ??= LightThemes._init();
    return _instace!;
  }

  LightThemes._init();
}
