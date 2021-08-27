import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import 'animated_app_bar.dart';

class AnimatedScaffold extends StatefulWidget {
  final AnimationController? controller;

  /// Refer to [Scaffold.body] documentation.
  final Widget? body;

  final AnimatedAppBar? appBar;

  /// Refer to [Scaffold.floatingActionButton] documentation.
  final Widget? floatingActionButton;

  /// Refer to [Scaffold.floatingActionButtonLocation] documentation.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Refer to [Scaffold.floatingActionButtonAnimator] documentation.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// Refer to [Scaffold.persistentFooterButtons] documentation.
  final List<Widget>? persistentFooterButtons;

  /// Refer to [Scaffold.drawer] documentation.
  final Widget? drawer;

  /// Refer to [Scaffold.onDrawerChanged] documentation.
  final void Function(bool)? onDrawerChanged;

  /// Refer to [Scaffold.endDrawer] documentation.
  final Widget? endDrawer;

  /// Refer to [Scaffold.onEndDrawerChanged] documentation.
  final void Function(bool)? onEndDrawerChanged;

  /// Refer to [Scaffold.bottomNavigationBar] documentation.
  final Widget? bottomNavigationBar;

  /// Refer to [Scaffold.bottomSheet] documentation.
  final Widget? bottomSheet;

  /// Refer to [Scaffold.backgroundColor] documentation.
  final Color? backgroundColor;

  /// Refer to [Scaffold.resizeToAvoidBottomInset] documentation.
  final bool? resizeToAvoidBottomInset;

  /// Refer to [Scaffold.primary] documentation.
  final bool primary;

  /// Refer to [Scaffold.drawerDragStartBehavior] documentation.
  final DragStartBehavior drawerDragStartBehavior;

  /// Refer to [Scaffold.extendBody] documentation.
  final bool extendBody;

  /// Refer to [Scaffold.extendBodyBehindAppBar] documentation.
  final bool extendBodyBehindAppBar;

  /// Refer to [Scaffold.drawerScrimColor] documentation.
  final Color? drawerScrimColor;

  /// Refer to [Scaffold.drawerEdgeDragWidth] documentation.
  final double? drawerEdgeDragWidth;

  /// Refer to [Scaffold.drawerEnableOpenDragGesture] documentation.
  final bool drawerEnableOpenDragGesture;

  /// Refer to [Scaffold.endDrawerEnableOpenDragGesture] documentation.
  final bool endDrawerEnableOpenDragGesture;

  /// Refer to [Scaffold.restorationId] documentation.
  final String? restorationId;

  /// Wrapper for the [Scaffold] widget that adds a [AnimatedAppBar].
  const AnimatedScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.controller,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);

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
  late final Animation<double> _animation = CurvedAnimation(
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
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        onDrawerChanged: widget.onDrawerChanged,
        endDrawer: widget.endDrawer,
        onEndDrawerChanged: widget.onEndDrawerChanged,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        drawerScrimColor: widget.drawerScrimColor,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
        restorationId: widget.restorationId,
      );
}

class _AnimatedScaffoldBottom extends AnimatedWidget {
  final Widget? body;
  final AnimatedAppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final void Function(bool)? onDrawerChanged;
  final Widget? endDrawer;
  final void Function(bool)? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  const _AnimatedScaffoldBottom({
    required Animation<double> animation,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
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
              shadowColor: appBar!.shadowColor,
              shape: appBar!.shape,
              backgroundColor: appBar!.backgroundColor,
              brightness: appBar!.brightness,
              iconTheme: appBar!.iconTheme,
              actionsIconTheme: appBar!.actionsIconTheme,
              textTheme: appBar!.textTheme,
              primary: appBar!.primary,
              centerTitle: appBar!.centerTitle,
              excludeHeaderSemantics: appBar!.excludeHeaderSemantics,
              titleSpacing: appBar!.titleSpacing,
              toolbarOpacity: appBar!.toolbarOpacity,
              bottomOpacity: appBar!.bottomOpacity,
              toolbarHeight: appBar!.toolbarHeight,
              leadingWidth: appBar!.leadingWidth,
              backwardsCompatibility: appBar!.backwardsCompatibility,
              toolbarTextStyle: appBar!.toolbarTextStyle,
              titleTextStyle: appBar!.titleTextStyle,
              systemOverlayStyle: appBar!.systemOverlayStyle,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }
}
