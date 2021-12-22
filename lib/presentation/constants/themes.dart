import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

extension on Brightness {
  ThemeMode toThemeMode() {
    switch (this) {
      case Brightness.light:
        return ThemeMode.light;
      case Brightness.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

abstract class MyThemes {
  static final _baseDark = ThemeData.dark();
  static final _baseLight = ThemeData.light();

  static final dark = _baseDark.copyWith(
    brightness: Brightness.dark,
    appBarTheme: _baseDark.appBarTheme.copyWith(
      backgroundColor: MyColors.appBarBackgroundDark,
      elevation: 0,
    ),
    colorScheme: _baseDark.colorScheme.copyWith(
      secondary: MyColors.yellow,
    ),
    bottomNavigationBarTheme: _baseLight.bottomNavigationBarTheme.copyWith(
      backgroundColor: MyColors.bottomNavBarDark,
      selectedItemColor: MyColors.bottomNavBarSelectedItemDark,
      unselectedItemColor: Colors.white.withOpacity(0.4),
    ),
    scaffoldBackgroundColor: MyColors.appBarBackgroundDark,
    dialogTheme: _baseLight.dialogTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  static final light = _baseLight.copyWith(
    brightness: Brightness.light,
    appBarTheme: _baseLight.appBarTheme.copyWith(
      elevation: 0,
      backgroundColor: MyColors.appBarBackground,
    ),
    colorScheme: _baseDark.colorScheme.copyWith(
      secondary: MyColors.yellow,
    ),
    bottomNavigationBarTheme: _baseLight.bottomNavigationBarTheme.copyWith(
      backgroundColor: MyColors.bottomNavBar,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.4),
    ),
    scaffoldBackgroundColor: MyColors.appBarBackground,
    dialogTheme: _baseLight.dialogTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  static void changeBrightness(BuildContext context, {ThemeMode? themeMode}) {
    final newBrightness = Theme.of(context).brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    DynamicTheme.of(context)
        .setThemeMode(themeMode ?? newBrightness.toThemeMode());
  }
}
