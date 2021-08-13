import 'package:flutter/material.dart';

class MyColors {
  // Light Theme
  static const bottomNavBar = Color(0xFFb25819);

  // Dark Theme
  static const bottomNavBarDark = Color(0xFF2e2e2e);
  static const bottomNavBarSelectedItemDark = Color(0xFFcdb16f);
  static const appBarBackgroundDark = Color(0xFF121212);
  static const scaffoldBackgroundDark = Color(0xFF282828);
}

class DynamicThemedColors {
  static Color _dynamicColor({
    required BuildContext context,
    required Color light,
    required Color dark,
  }) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? light : dark;
  }

  static Color scaffoldBackground(BuildContext context) => _dynamicColor(
        context: context,
        light: Colors.white,
        dark: MyColors.scaffoldBackgroundDark,
      );
}
