import 'package:flutter/material.dart';

import '../../core/consts/durations.dart';

class MagicCircleProgressIndicator extends ProgressIndicator {
  final double? size;

  const MagicCircleProgressIndicator({
    Key? key,
    double? value,
    Color? color,
    Animation<Color?>? valueColor,
    this.size,
  }) : super(
          key: key,
          value: value,
          color: color,
          valueColor: valueColor,
        );

  @override
  State<StatefulWidget> createState() => _MagicCircleProgressIndicatorState();
}

class _MagicCircleProgressIndicatorState
    extends State<MagicCircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Durations.sec5,
  )..repeat();

  late final _rotationTween = Tween<double>(begin: 0, end: 1.0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressIndicator = RotationTransition(
      turns: _rotationTween.animate(_controller),
      child: Image.asset(
        'assets/magic_circle.png',
        color: widget.color ??
            widget.valueColor?.value ??
            Theme.of(context).colorScheme.secondary,
      ),
    );
    return widget.size != null
        ? SizedBox(
            width: widget.size,
            height: widget.size,
            child: progressIndicator,
          )
        : progressIndicator;
  }
}
