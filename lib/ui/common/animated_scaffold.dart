import 'package:flutter/material.dart';

final _sizeTween = Tween<double>(begin: 0, end: 300);

class AnimatedScaffold extends StatefulWidget {
  final AnimationController? controller;
  final Widget? body;
  final AnimatedAppBar? appBar;

  const AnimatedScaffold({
    this.body,
    this.appBar,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedScaffoldState();
}

class _AnimatedScaffoldState extends State<AnimatedScaffold>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = widget.controller ??
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _AnimatedScaffoldBottom(
        animation: _animation,
        body: widget.body,
        appBar: widget.appBar,
      );
}

class _AnimatedScaffoldBottom extends AnimatedWidget {
  final Widget? body;
  final AnimatedAppBar? appBar;

  const _AnimatedScaffoldBottom({
    required Animation<double> animation,
    this.body,
    this.appBar,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final bottomSize = Size.fromHeight(
      _sizeTween.evaluate(listenable as Animation<double>),
    );
    return Scaffold(
      appBar: appBar != null
          ? AppBar(
              leading: appBar!.leading,
              automaticallyImplyLeading: appBar!.automaticallyImplyLeading,
              title: appBar!.title,
              actions: appBar!.actions,
              flexibleSpace: appBar!.flexibleSpace,
              bottom: PreferredSize(
                preferredSize: bottomSize,
                child: Container(color: Colors.red),
              ),
              elevation: appBar!.elevation,
            )
          : null,
      body: body,
    );
  }
}

abstract class AnimatedAppBar {
  Widget? get leading;
  bool get automaticallyImplyLeading;
  Widget? get title;
  List<Widget>? get actions;
  Widget? get flexibleSpace;
  double? get elevation;
}

class AnimatedAppBarBottom implements AnimatedAppBar {
  @override
  final Widget? leading;

  @override
  final bool automaticallyImplyLeading;

  @override
  final Widget? title;

  @override
  final List<Widget>? actions;

  @override
  final Widget? flexibleSpace;

  @override
  final double? elevation;

  AnimatedAppBarBottom({
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.elevation,
  });
}
