import 'package:flutter/material.dart';

abstract class AnimatedAppBar {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final Widget? bottom;
  final double? elevation;
  final Tween<double> sizeTween;
  final bool automaticallyImplyLeading;

  AnimatedAppBar({
    required this.sizeTween,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.title,
    this.bottom,
    this.elevation,
  });
}

class AnimatedAppBarBottom extends AnimatedAppBar {
  AnimatedAppBarBottom({
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    Widget? bottom,
    double? elevation,
    double bottomHeight = 0,
    double bottomExpandedHeight = 50,
  }) : super(
          sizeTween:
              Tween<double>(begin: bottomHeight, end: bottomExpandedHeight),
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          elevation: elevation,
          bottom: bottom,
        );
}
