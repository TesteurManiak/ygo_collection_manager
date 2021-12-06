import 'package:flutter/material.dart';

import 'consts.dart';

abstract class MyEdgeInsets {
  // only

  // symmetric
  static const symH4 = EdgeInsets.symmetric(horizontal: Consts.px4);
  static const symH10V12 = EdgeInsets.symmetric(
    horizontal: Consts.px10,
    vertical: Consts.px12,
  );

  // all
  static const all25 = EdgeInsets.all(Consts.px25);
}
