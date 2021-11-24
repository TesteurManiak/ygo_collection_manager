import 'package:flutter/material.dart';

class MagicCircleProgressIndicator extends ProgressIndicator {
  const MagicCircleProgressIndicator({
    Key? key,
    double? value,
    Color? color,
    Animation<Color?>? valueColor,
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
    duration: const Duration(seconds: 5),
  )..repeat();

  late final _rotationTween = Tween<double>(begin: 0, end: 1.0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationTween.animate(_controller),
      child: Image.asset(
        'assets/magic_circle.png',
        color: widget.color ??
            widget.valueColor?.value ??
            Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
