import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: appBar != null
          ? AppBar(
              leading: appBar!.leading,
              automaticallyImplyLeading: appBar!.automaticallyImplyLeading,
              title: appBar!.title,
              actions: appBar!.actions,
              flexibleSpace: appBar!.flexibleSpace,
              bottom: appBar!.bottom != null
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(appBar!.sizeTween
                          .evaluate(listenable as Animation<double>)),
                      child: appBar!.bottom!,
                    )
                  : null,
              elevation: appBar!.elevation,
            )
          : null,
      body: body,
    );
  }
}

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
