import 'package:flutter/material.dart';

typedef AppBarBottomBuilder = PreferredSizeWidget? Function(double value);

class ExpandingAppBarBottom extends AppBar {
  ExpandingAppBarBottom({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    double? elevation,
    AppBarBottomBuilder? bottomBuilder,
    double bottomHeight = 0.0,
    double bottomExpandedHeight = 50.0,
    required Animation<double> animation,
  }) : super(
          key: key,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          elevation: elevation,
          bottom: bottomBuilder?.call(
            _createAnimatable(bottomHeight, bottomExpandedHeight)
                .evaluate(animation),
          ),
        );

  static Tween<double> _createAnimatable(
    double bottomHeight,
    double bottomExpandedHeight,
  ) =>
      Tween<double>(
        begin: bottomHeight,
        end: bottomExpandedHeight,
      );
}
