import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import 'animated_app_bar.dart';

class AnimatedAppBarScaffold extends AnimatedWidget {
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

  const AnimatedAppBarScaffold({
    Key? key,
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
  }) : super(listenable: animation, key: key);

  @override
  Widget build(BuildContext context) {
    final _appBar = appBar;
    final _bottomBuilder = appBar?.bottomBuilder;
    return Scaffold(
      appBar: _appBar != null
          ? AppBar(
              leading: _appBar.leading,
              automaticallyImplyLeading: _appBar.automaticallyImplyLeading,
              title: _appBar.title,
              actions: _appBar.actions,
              flexibleSpace: _appBar.flexibleSpace,
              bottom: _bottomBuilder?.call(
                _appBar.animatable.evaluate(listenable as Animation<double>),
              ),
              elevation: _appBar.elevation,
              shadowColor: _appBar.shadowColor,
              shape: _appBar.shape,
              backgroundColor: _appBar.backgroundColor,
              iconTheme: _appBar.iconTheme,
              actionsIconTheme: _appBar.actionsIconTheme,
              primary: _appBar.primary,
              centerTitle: _appBar.centerTitle,
              excludeHeaderSemantics: _appBar.excludeHeaderSemantics,
              titleSpacing: _appBar.titleSpacing,
              toolbarOpacity: _appBar.toolbarOpacity,
              bottomOpacity: _appBar.bottomOpacity,
              toolbarHeight: _appBar.toolbarHeight,
              leadingWidth: _appBar.leadingWidth,
              toolbarTextStyle: _appBar.toolbarTextStyle,
              titleTextStyle: _appBar.titleTextStyle,
              systemOverlayStyle: _appBar.systemOverlayStyle,
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
