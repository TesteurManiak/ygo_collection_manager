import 'package:flutter/material.dart';

import 'consts.dart';

abstract class MyEdgeInsets {
  // only
  static const onlyR4 = EdgeInsets.only(right: Consts.px4);
  static const onlyT16 = EdgeInsets.only(top: Consts.px16);

  // symmetric
  static const symH4 = EdgeInsets.symmetric(horizontal: Consts.px4);
  static const symH6V4 = EdgeInsets.symmetric(
    horizontal: Consts.px6,
    vertical: Consts.px4,
  );
  static const symH10V12 = EdgeInsets.symmetric(
    horizontal: Consts.px10,
    vertical: Consts.px12,
  );
  static const symH16 = EdgeInsets.symmetric(horizontal: Consts.px16);
  static const symH16V8 = EdgeInsets.symmetric(
    horizontal: Consts.px16,
    vertical: Consts.px8,
  );

  // all
  static const all2 = EdgeInsets.all(Consts.px2);
  static const all8 = EdgeInsets.all(Consts.px8);
  static const all16 = EdgeInsets.all(Consts.px16);
  static const all25 = EdgeInsets.all(Consts.px25);
}
