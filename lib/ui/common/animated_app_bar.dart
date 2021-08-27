import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import 'animated_scaffold.dart';

/// Usable only in [AnimatedScaffold.appBar] property.
abstract class AnimatedAppBar {
  /// Refer to [AppBar.leading] documentation.
  final Widget? leading;

  /// Refer to [AppBar.title] documentation.
  final Widget? title;

  /// Refer to [AppBar.actions] documentation.
  final List<Widget>? actions;

  /// Refer to [AppBar.bottom] documentation.
  final Widget? flexibleSpace;

  /// Similar to [AppBar.bottom], this widget will appears accross the bottom of
  /// the app bar.
  ///
  /// As it is a [Widget] without any size constraints by itself you will need
  /// to set a height big enough to contain your widget in the
  /// [AnimatedAppBar.sizeTween] property.
  final Widget? bottom;

  /// Refer to [AppBar.elevation] documentation.
  final double? elevation;

  final Tween<double> sizeTween;

  /// Refer to [AppBar.automaticallyImplyLeading] documentation.
  final bool automaticallyImplyLeading;

  /// Refer to [AppBar.shadowColor] documentation.
  final Color? shadowColor;

  /// Refer to [AppBar.shape] documentation.
  final ShapeBorder? shape;

  /// Refer to [AppBar.backgroundColor] documentation.
  final Color? backgroundColor;

  /// Refer to [AppBar.foregroundColor] documentation.
  final Color? foregroundColor;

  /// Refer to [AppBar.brightness] documentation.
  final Brightness? brightness;

  /// Refer to [AppBar.iconTheme] documentation.
  final IconThemeData? iconTheme;

  /// Refer to [AppBar.actionsIconTheme] documentation.
  final IconThemeData? actionsIconTheme;

  /// Refer to [AppBar.textTheme] documentation.
  final TextTheme? textTheme;

  /// Refer to [AppBar.primary] documentation.
  final bool primary;

  /// Refer to [AppBar.centerTitle] documentation.
  final bool? centerTitle;

  /// Refer to [AppBar.excludeHeaderSemantics] documentation.
  final bool excludeHeaderSemantics;

  /// Refer to [AppBar.titleSpacing] documentation.
  final double? titleSpacing;

  /// Refer to [AppBar.toolbarOpacity] documentation.
  final double toolbarOpacity;

  /// Refer to [AppBar.bottomOpacity] documentation.
  final double bottomOpacity;

  /// Refer to [AppBar.toolbarHeight] documentation.
  final double? toolbarHeight;

  /// Refer to [AppBar.leadingWidth] documentation.
  final double? leadingWidth;

  /// Refer to [AppBar.backwardsCompatibility] documentation.
  final bool? backwardsCompatibility;

  /// Refer to [AppBar.toolbarTextStyle] documentation.
  final TextStyle? toolbarTextStyle;

  /// Refer to [AppBar.titleTextStyle] documentation.
  final TextStyle? titleTextStyle;

  /// Refer to [AppBar.systemOverlayStyle] documentation.
  final SystemUiOverlayStyle? systemOverlayStyle;

  AnimatedAppBar({
    required this.sizeTween,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.title,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.backwardsCompatibility,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  }) : assert(elevation == null || elevation >= 0.0);
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
