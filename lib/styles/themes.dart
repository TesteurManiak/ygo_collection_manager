import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/common/dynamic_theme.dart';

extension BrightnessModifier on Brightness {
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

// ignore: avoid_classes_with_only_static_members
class MyThemes {
  static final _baseDark = ThemeData.dark();
  static final _baseLight = ThemeData.light();

  static ThemeData get dark {
    final _dark = _baseDark.copyWith(
      appBarTheme: _baseDark.appBarTheme.copyWith(
        backgroundColor: MyColors.appBarBackgroundDark,
        elevation: 0,
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
    return _dark;
  }

  static ThemeData get light {
    final _light = _baseLight.copyWith(
      appBarTheme: _baseLight.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: MyColors.appBarBackground,
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
    return _light;
  }

  static ThemeData fromBrightness(
      ThemeMode themeMode, Brightness? systemBrightness) {
    if (themeMode == ThemeMode.system) {
      return systemBrightness == Brightness.dark ? dark : light;
    }
    return themeMode == ThemeMode.dark ? dark : light;
  }

  static void changeBrightness(BuildContext context, {ThemeMode? themeMode}) {
    final newBrightness = Theme.of(context).brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    DynamicTheme.of(context)
        ?.setBrightness(themeMode ?? newBrightness.toThemeMode());
  }
}
