import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../constants/colors.dart';

/// Creates a [DecoratedBox] with [color] as its background color and a vertical
/// top rounded border.
///
/// If [color] is not provided, the [ DynamicThemedColors.scaffoldBackground]
/// will be used.
class RoundedScaffoldBox extends StatelessWidget {
  final Widget? child;
  final Color? color;

  const RoundedScaffoldBox({
    Key? key,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? DynamicThemedColors.scaffoldBackground(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Consts.px20),
        ),
      ),
      child: child,
    );
  }
}
