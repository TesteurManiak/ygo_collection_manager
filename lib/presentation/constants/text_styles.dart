import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import 'colors.dart';

abstract class TextStyles {
  // grey
  static const grey14 = TextStyle(
    color: MyColors.grey,
    fontSize: Consts.px14,
  );

  // default
  static const font16 = TextStyle(fontSize: Consts.px16);
  static const font18w500 = TextStyle(
    fontSize: Consts.px18,
    fontWeight: FontWeight.w500,
  );
  static const font20 = TextStyle(fontSize: Consts.px20);

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
        fontSize: Consts.px14,
      );
}
