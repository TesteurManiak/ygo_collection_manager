import 'package:flutter/material.dart';

import 'no_glow_scroll_behavior.dart';

/// Creates a [CustomScrollView] with a [NoGlowScrollBehavior].
class NoGlowCustomScrollView extends StatelessWidget {
  final List<Widget> slivers;

  const NoGlowCustomScrollView({
    Key? key,
    this.slivers = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const NoGlowScrollBehavior(),
      child: CustomScrollView(
        primary: false,
        slivers: slivers,
      ),
    );
  }
}
