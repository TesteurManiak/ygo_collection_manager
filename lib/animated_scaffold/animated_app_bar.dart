import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

typedef AppBarBottomBuilder = PreferredSizeWidget? Function(double value);

abstract class AnimatedAppBar {
  /// Refer to [AppBar.leading] documentation.
  final Widget? leading;

  /// Refer to [AppBar.title] documentation.
  final Widget? title;

  /// Refer to [AppBar.actions] documentation.
  final List<Widget>? actions;

  /// Refer to [AppBar.bottom] documentation.
  final Widget? flexibleSpace;

  /// `value` of this object for the given [Animation]
  final AppBarBottomBuilder? bottomBuilder;

  /// Refer to [AppBar.elevation] documentation.
  final double? elevation;

  final Animatable<double> animatable;

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

  /// Refer to [AppBar.iconTheme] documentation.
  final IconThemeData? iconTheme;

  /// Refer to [AppBar.actionsIconTheme] documentation.
  final IconThemeData? actionsIconTheme;

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

  /// Refer to [AppBar.toolbarTextStyle] documentation.
  final TextStyle? toolbarTextStyle;

  /// Refer to [AppBar.titleTextStyle] documentation.
  final TextStyle? titleTextStyle;

  /// Refer to [AppBar.systemOverlayStyle] documentation.
  final SystemUiOverlayStyle? systemOverlayStyle;

  AnimatedAppBar({
    required this.animatable,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.title,
    this.bottomBuilder,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  }) : assert(elevation == null || elevation >= 0.0);
}

class ExpandingAppBarBottom extends AnimatedAppBar {
  ExpandingAppBarBottom({
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    double? elevation,
    AppBarBottomBuilder? bottomBuilder,
    double bottomHeight = 0,
    double bottomExpandedHeight = 50,
  }) : super(
          animatable:
              Tween<double>(begin: bottomHeight, end: bottomExpandedHeight),
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          elevation: elevation,
          bottomBuilder: bottomBuilder,
        );
}
