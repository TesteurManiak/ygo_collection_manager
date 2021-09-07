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
    return Scaffold(
      appBar: appBar != null
          ? AppBar(
              leading: appBar!.leading,
              automaticallyImplyLeading: appBar!.automaticallyImplyLeading,
              title: appBar!.title,
              actions: appBar!.actions,
              flexibleSpace: appBar!.flexibleSpace,
              bottom: appBar?.bottomBuilder != null
                  ? appBar?.bottomBuilder!(appBar!.animatable
                      .evaluate(listenable as Animation<double>))
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
