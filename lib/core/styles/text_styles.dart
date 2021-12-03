import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles {
  // grey
  static const grey14 = TextStyle(color: MyColors.grey, fontSize: 14);

  // default
  static const font18w500 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const font20 = TextStyle(fontSize: 20);

  // black
  static const black12b = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

class DynamicTextStyles {
  static Color _dynamicColor({
    required BuildContext context,
    required Color light,
    required Color dark,
  }) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? light : dark;
  }

  static TextStyle cardId(BuildContext context) => TextStyle(
        color: _dynamicColor(
          context: context,
          light: Colors.black,
          dark: Colors.white,
        ),
        fontSize: 14,
      );
}
