import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class TextStyles {
  // grey
  static const grey14 = TextStyle(color: MyColors.grey, fontSize: 14);

  // default
  static const font12b = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const font20 = TextStyle(fontSize: 20);
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
