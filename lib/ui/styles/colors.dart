import 'package:flutter/material.dart';

class MyColors {
  // Light Theme
  static const bottomNavBar = Color(0xFFb25819);
  static const appBarBackground = Color(0xFFb25819);
  static const cardSetBorder = Color(0xFFe1e1e1);

  // Dark Theme
  static const bottomNavBarDark = Color(0xFF2e2e2e);
  static const bottomNavBarSelectedItemDark = Color(0xFFcdb16f);
  static const appBarBackgroundDark = Color(0xFF121212);
  static const scaffoldBackgroundDark = Color(0xFF282828);
  static const cardSetBorderDark = Color(0xFF4c4c4c);
  static const cardBottomSheetDark = Color(0xFF222222);

  static const grey = Color(0xFFa7a7a7);
  static const yellow = Color(0xFFcda95d);
  static const yellow2 = Color(0xFFd1a954);
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

  static Color cardSetBorder(BuildContext context) => _dynamicColor(
        context: context,
        light: MyColors.cardSetBorder,
        dark: MyColors.cardSetBorderDark,
      );

  static Color bottomSheetBackground(BuildContext context) => _dynamicColor(
        context: context,
        light: Colors.white,
        dark: MyColors.cardBottomSheetDark,
      );
}
