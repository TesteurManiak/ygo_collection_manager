import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

typedef AnimatedWidgetBuilder<T extends Widget> = T Function(Listenable);

/// Wrapping around the [Scaffold] widget. This widget extends [AnimatedWidget]
/// to provide animation capabilites when building certain widgets.
///
/// The properties which can be animated are:
/// - [appBar] with [appBarBuilder]
/// - [body] with [bodyBuilder]
/// - [floatingActionButton] with [floatingActionButtonBuilder]
/// - [bottomNavigationBar] with [bottomNavigationBarBuilder]
class AnimatedScaffold extends AnimatedWidget {
  final Widget? body;
  final AnimatedWidgetBuilder<Widget>? bodyBuilder;
  final PreferredSizeWidget? appBar;
  final AnimatedWidgetBuilder<PreferredSizeWidget>? appBarBuilder;
  final Widget? floatingActionButton;
  final AnimatedWidgetBuilder<Widget>? floatingActionButtonBuilder;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final void Function(bool)? onDrawerChanged;
  final Widget? endDrawer;
  final void Function(bool)? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final AnimatedWidgetBuilder<Widget>? bottomNavigationBarBuilder;
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

  const AnimatedScaffold({
    Key? key,
    required Animation<double> animation,
    this.body,
    this.bodyBuilder,
    this.appBar,
    this.appBarBuilder,
    this.floatingActionButton,
    this.floatingActionButtonBuilder,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomNavigationBarBuilder,
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
  })  : assert(
          body == null || bodyBuilder == null,
          "Only one of body and bodyBuilder can be specified",
        ),
        assert(
          appBar == null || appBarBuilder == null,
          "Only one of appBar and appBarBuilder can be specified",
        ),
        assert(
          floatingActionButton == null || floatingActionButtonBuilder == null,
          "Only one of floatingActionButton and floatingActionButtonBuilder can be specified",
        ),
        assert(
          bottomNavigationBar == null || bottomNavigationBarBuilder == null,
          "Only one of bottomNavigationBar and bottomNavigationBarBuilder can be specified",
        ),
        super(listenable: animation, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? appBarBuilder?.call(listenable),
      body: body ?? bodyBuilder?.call(listenable),
      floatingActionButton:
          floatingActionButton ?? floatingActionButtonBuilder?.call(listenable),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar:
          bottomNavigationBar ?? bottomNavigationBarBuilder?.call(listenable),
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
