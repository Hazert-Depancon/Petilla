import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      primaryColorLight: Colors.white,
      useMaterial3: true,
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
      brightness: Brightness.light,
      indicatorColor: LightThemeColors.miamiMarmalade,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: LightThemeColors.miamiMarmalade.withOpacity(.3),
        onPrimary: LightThemeColors.white,
        secondary: LightThemeColors.white,
        onSecondary: LightThemeColors.white,
        error: LightThemeColors.red,
        onError: LightThemeColors.red,
        background: LightThemeColors.scaffoldBackgroundColor,
        onBackground: LightThemeColors.white,
        surface: LightThemeColors.white,
        onSurface: LightThemeColors.black,
      ),
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
        bodyMedium: TextStyle(
          color: LightThemeColors.miamiMarmalade,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
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
