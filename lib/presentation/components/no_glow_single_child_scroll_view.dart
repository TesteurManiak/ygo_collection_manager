import 'package:flutter/material.dart';

import 'no_glow_scroll_behavior.dart';

/// Creates a [SingleChildScrollView] with a [NoGlowScrollBehavior].
class NoGlowSingleChildScrollView extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;

  const NoGlowSingleChildScrollView({
    Key? key,
    this.child,
    this.padding,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const NoGlowScrollBehavior(),
      child: SingleChildScrollView(
        padding: padding,
        controller: controller,
        child: child,
      ),
    );
  }
}
