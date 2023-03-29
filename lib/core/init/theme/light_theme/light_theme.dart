import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patily/core/init/theme/light_theme/light_theme_colors.dart';

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
        foregroundColor: LightThemeColors.miamiMarmalade,
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
        labelLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge:
            TextStyle(color: LightThemeColors.miamiMarmalade, fontSize: 20),
        titleSmall: TextStyle(fontSize: 16),
        headlineMedium: TextStyle(
          fontSize: 24,
          color: LightThemeColors.black,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          color: LightThemeColors.black,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(color: LightThemeColors.grey, fontSize: 18),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: LightThemeColors.miamiMarmalade,
        elevation: 0,
        highlightElevation: 0,
        foregroundColor: LightThemeColors.white,
      ),
    );
  }
}
