import 'dart:collection' show Queue;
import 'dart:math' as math;

import 'package:flutter/material.dart' hide BottomNavigationBar;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class FixedBottomNavigationBar extends StatefulWidget {
  FixedBottomNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    this.type,
    Color? fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    Color? selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.mouseCursor,
    this.enableFeedback,
  })  : assert(items.length >= 2),
        assert(
          items.every((BottomNavigationBarItem item) => item.label != null),
          'Every item must have a non-null label',
        ),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(elevation == null || elevation >= 0.0),
        assert(iconSize >= 0.0),
        assert(
          selectedItemColor == null || fixedColor == null,
          'Either selectedItemColor or fixedColor can be specified, but not both',
        ),
        assert(selectedFontSize >= 0.0),
        assert(unselectedFontSize >= 0.0),
        selectedItemColor = selectedItemColor ?? fixedColor,
        super(key: key);

  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final double? elevation;
  final BottomNavigationBarType? type;
  Color? get fixedColor => selectedItemColor;
  final Color? backgroundColor;
  final double iconSize;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool? showUnselectedLabels;
  final bool? showSelectedLabels;
  final MouseCursor? mouseCursor;
  final bool? enableFeedback;

  @override
  _FixedBottomNavigationBarState createState() =>
      _FixedBottomNavigationBarState();
}

class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.type,
    this.item,
    this.animation,
    this.iconSize, {
    this.onTap,
    this.colorTween,
    this.flex,
    this.selected = false,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    this.indexLabel,
    required this.mouseCursor,
    required this.enableFeedback,
  });

  final BottomNavigationBarType type;
  final BottomNavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final ColorTween? colorTween;
  final double? flex;
  final bool selected;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final String? indexLabel;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final MouseCursor mouseCursor;
  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    final int size;

    final double selectedFontSize = selectedLabelStyle.fontSize!;

    final double selectedIconSize = selectedIconTheme?.size ?? iconSize;
    final double unselectedIconSize = unselectedIconTheme?.size ?? iconSize;

    final double selectedIconDiff =
        math.max(selectedIconSize - unselectedIconSize, 0);
    final double unselectedIconDiff =
        math.max(unselectedIconSize - selectedIconSize, 0);

    final String? effectiveTooltip =
        item.tooltip == '' ? null : item.tooltip ?? item.label;

    double bottomPadding;
    double topPadding;
    if (showSelectedLabels && !showUnselectedLabels) {
      bottomPadding = Tween<double>(
        begin: selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 - unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 - unselectedIconDiff / 2.0,
      ).evaluate(animation);
    } else if (!showSelectedLabels && !showUnselectedLabels) {
      bottomPadding = Tween<double>(
        begin: selectedIconDiff / 2.0,
        end: unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize + selectedIconDiff / 2.0,
        end: selectedFontSize + unselectedIconDiff / 2.0,
      ).evaluate(animation);
    } else {
      bottomPadding = Tween<double>(
        begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
      ).evaluate(animation);
    }

    switch (type) {
      case BottomNavigationBarType.fixed:
        size = 1;
        break;
      case BottomNavigationBarType.shifting:
        size = (flex! * 1000.0).round();
        break;
    }

    Widget result = InkResponse(
      onTap: onTap,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _TileIcon(
              colorTween: colorTween!,
              animation: animation,
              iconSize: iconSize,
              selected: selected,
              item: item,
              selectedIconTheme: selectedIconTheme,
              unselectedIconTheme: unselectedIconTheme,
            ),
            _Label(
              colorTween: colorTween!,
              animation: animation,
              item: item,
              selectedLabelStyle: selectedLabelStyle,
              unselectedLabelStyle: unselectedLabelStyle,
              showSelectedLabels: showSelectedLabels,
              showUnselectedLabels: showUnselectedLabels,
            ),
          ],
        ),
      ),
    );

    if (effectiveTooltip != null) {
      result = Tooltip(
        message: effectiveTooltip,
        preferBelow: false,
        verticalOffset: selectedIconSize + selectedFontSize,
        excludeFromSemantics: true,
        child: result,
      );
    }

    result = Semantics(
      selected: selected,
      container: true,
      child: Stack(
        children: <Widget>[
          result,
          Semantics(
            label: indexLabel,
          ),
        ],
      ),
    );

    return Expanded(
      flex: size,
      child: result,
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({
    Key? key,
    required this.colorTween,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
  }) : super(key: key);

  final ColorTween colorTween;
  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final BottomNavigationBarItem item;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = colorTween.evaluate(animation);
    final IconThemeData defaultIconTheme = IconThemeData(
      color: iconColor,
      size: iconSize,
    );
    final IconThemeData iconThemeData = IconThemeData.lerp(
      defaultIconTheme.merge(unselectedIconTheme),
      defaultIconTheme.merge(selectedIconTheme),
      animation.value,
    );

    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: IconTheme(
        data: iconThemeData,
        child: selected ? item.activeIcon : item.icon,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    Key? key,
    required this.colorTween,
    required this.animation,
    required this.item,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
  }) : super(key: key);

  final ColorTween colorTween;
  final Animation<double> animation;
  final BottomNavigationBarItem item;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    final double? selectedFontSize = selectedLabelStyle.fontSize;
    final double? unselectedFontSize = unselectedLabelStyle.fontSize;

    final TextStyle customStyle = TextStyle.lerp(
      unselectedLabelStyle,
      selectedLabelStyle,
      animation.value,
    )!;
    Widget text = DefaultTextStyle.merge(
      style: customStyle.copyWith(
        fontSize: selectedFontSize,
        color: colorTween.evaluate(animation),
      ),
      child: Transform(
        transform: Matrix4.diagonal3(
          Vector3.all(
            Tween<double>(
              begin: unselectedFontSize! / selectedFontSize!,
              end: 1.0,
            ).evaluate(animation),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Text(item.label!),
      ),
    );

    if (!showUnselectedLabels && !showSelectedLabels) {
      // Never show any labels.
      text = Opacity(
        alwaysIncludeSemantics: true,
        opacity: 0.0,
        child: text,
      );
    } else if (!showUnselectedLabels) {
      text = IgnorePointer(
        child: FadeTransition(
          alwaysIncludeSemantics: true,
          opacity: animation,
          child: text,
        ),
      );
    } else if (!showSelectedLabels) {
      text = FadeTransition(
        alwaysIncludeSemantics: true,
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
        child: text,
      );
    }

    text = Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(child: text),
    );

    if (item.label != null) {
      final MediaQueryData mediaQueryData = MediaQuery.of(context);
      text = MediaQuery(
        data: mediaQueryData.copyWith(
          textScaleFactor: math.min(1.0, mediaQueryData.textScaleFactor),
        ),
        child: text,
      );
    }

    return text;
  }
}

class _FixedBottomNavigationBarState extends State<FixedBottomNavigationBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;

  final Queue<_Circle> _circles = Queue<_Circle>();

  Color? _backgroundColor;

  static final Animatable<double> _flexTween =
      Tween<double>(begin: 1.0, end: 1.5);

  void _resetState() {
    for (final AnimationController controller in _controllers) {
      controller.dispose();
    }
    for (final _Circle circle in _circles) {
      circle.dispose();
    }
    _circles.clear();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  BottomNavigationBarType get _effectiveType {
    return widget.type ??
        BottomNavigationBarTheme.of(context).type ??
        (widget.items.length <= 3
            ? BottomNavigationBarType.fixed
            : BottomNavigationBarType.shifting);
  }

  bool get _defaultShowUnselected {
    switch (_effectiveType) {
      case BottomNavigationBarType.shifting:
        return false;
      case BottomNavigationBarType.fixed:
        return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (final AnimationController controller in _controllers) {
      controller.dispose();
    }
    for (final _Circle circle in _circles) {
      circle.dispose();
    }
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  void _pushCircle(int index) {
    if (widget.items[index].backgroundColor != null) {
      _circles.add(
        _Circle(
          state: this,
          index: index,
          color: widget.items[index].backgroundColor!,
          vsync: this,
        )..controller.addStatusListener(
            (AnimationStatus status) {
              switch (status) {
                case AnimationStatus.completed:
                  setState(() {
                    final _Circle circle = _circles.removeFirst();
                    _backgroundColor = circle.color;
                    circle.dispose();
                  });
                  break;
                case AnimationStatus.dismissed:
                case AnimationStatus.forward:
                case AnimationStatus.reverse:
                  break;
              }
            },
          ),
      );
    }
  }

  @override
  void didUpdateWidget(FixedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      switch (_effectiveType) {
        case BottomNavigationBarType.fixed:
          break;
        case BottomNavigationBarType.shifting:
          _pushCircle(widget.currentIndex);
          break;
      }
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex].backgroundColor) {
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
      }
    }
  }

  static TextStyle _effectiveTextStyle(TextStyle? textStyle, double fontSize) {
    final _textStyle = textStyle ?? const TextStyle();
    return _textStyle.fontSize == null
        ? _textStyle.copyWith(fontSize: fontSize)
        : _textStyle;
  }

  List<Widget> _createTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final ThemeData themeData = Theme.of(context);
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);

    final TextStyle effectiveSelectedLabelStyle = _effectiveTextStyle(
      widget.selectedLabelStyle ?? bottomTheme.selectedLabelStyle,
      widget.selectedFontSize,
    );
    final TextStyle effectiveUnselectedLabelStyle = _effectiveTextStyle(
      widget.unselectedLabelStyle ?? bottomTheme.unselectedLabelStyle,
      widget.unselectedFontSize,
    );

    final Color themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.colorScheme.primary;
        break;
      case Brightness.dark:
        themeColor = themeData.colorScheme.secondary;
        break;
    }

    final ColorTween colorTween;
    switch (_effectiveType) {
      case BottomNavigationBarType.fixed:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.unselectedWidgetColor,
          end: widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              widget.fixedColor ??
              themeColor,
        );
        break;
      case BottomNavigationBarType.shifting:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.colorScheme.surface,
          end: widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeData.colorScheme.surface,
        );
        break;
    }
    final MouseCursor effectiveMouseCursor =
        widget.mouseCursor ?? SystemMouseCursors.click;

    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      tiles.add(
        _BottomNavigationTile(
          _effectiveType,
          widget.items[i],
          _animations[i],
          widget.iconSize,
          selectedIconTheme:
              widget.selectedIconTheme ?? bottomTheme.selectedIconTheme,
          unselectedIconTheme:
              widget.unselectedIconTheme ?? bottomTheme.unselectedIconTheme,
          selectedLabelStyle: effectiveSelectedLabelStyle,
          unselectedLabelStyle: effectiveUnselectedLabelStyle,
          enableFeedback:
              widget.enableFeedback ?? bottomTheme.enableFeedback ?? true,
          onTap: () {
            widget.onTap?.call(i);
          },
          colorTween: colorTween,
          flex: _evaluateFlex(_animations[i]),
          selected: i == widget.currentIndex,
          showSelectedLabels: widget.showSelectedLabels ??
              bottomTheme.showSelectedLabels ??
              true,
          showUnselectedLabels: widget.showUnselectedLabels ??
              bottomTheme.showUnselectedLabels ??
              _defaultShowUnselected,
          indexLabel: localizations.tabLabel(
            tabIndex: i + 1,
            tabCount: widget.items.length,
          ),
          mouseCursor: effectiveMouseCursor,
        ),
      );
    }
    return tiles;
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasMediaQuery(context));
    assert(Overlay.of(context, debugRequiredFor: widget) != null);

    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);
    final double additionalBottomPadding =
        MediaQuery.of(context).padding.bottom;
    Color? backgroundColor;
    switch (_effectiveType) {
      case BottomNavigationBarType.fixed:
        backgroundColor = widget.backgroundColor ?? bottomTheme.backgroundColor;
        break;
      case BottomNavigationBarType.shifting:
        backgroundColor = _backgroundColor;
        break;
    }
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        elevation: widget.elevation ?? bottomTheme.elevation ?? 8.0,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: kBottomNavigationBarHeight + additionalBottomPadding,
          ),
          child: CustomPaint(
            painter: _RadialPainter(
              circles: _circles.toList(),
              textDirection: Directionality.of(context),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(bottom: additionalBottomPadding),
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: _createContainer(_createTiles()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Circle {
  _Circle({
    required this.state,
    required this.index,
    required this.color,
    required TickerProvider vsync,
  }) {
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
  }

  final _FixedBottomNavigationBarState state;
  final int index;
  final Color color;
  late AnimationController controller;
  late CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      return animations
          .map<double>(state._evaluateFlex)
          .fold<double>(0.0, (double sum, double value) => sum + value);
    }

    final double allWeights = weightSum(state._animations);
    final double leadingWeights =
        weightSum(state._animations.sublist(0, index));

    return (leadingWeights +
            state._evaluateFlex(state._animations[index]) / 2.0) /
        allWeights;
  }

  void dispose() {
    controller.dispose();
  }
}

class _RadialPainter extends CustomPainter {
  _RadialPainter({
    required this.circles,
    required this.textDirection,
  });

  final List<_Circle> circles;
  final TextDirection textDirection;

  static double _maxRadius(Offset center, Size size) {
    final double maxX = math.max(center.dx, size.width - center.dx);
    final double maxY = math.max(center.dy, size.height - center.dy);
    return math.sqrt(maxX * maxX + maxY * maxY);
  }

  @override
  bool shouldRepaint(_RadialPainter oldPainter) {
    if (textDirection != oldPainter.textDirection) return true;
    if (circles == oldPainter.circles) return false;
    if (circles.length != oldPainter.circles.length) return true;
    for (int i = 0; i < circles.length; i += 1) {
      if (circles[i] != oldPainter.circles[i]) return true;
    }
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final _Circle circle in circles) {
      final Paint paint = Paint()..color = circle.color;
      final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
      canvas.clipRect(rect);
      final double leftFraction;
      switch (textDirection) {
        case TextDirection.rtl:
          leftFraction = 1.0 - circle.horizontalLeadingOffset;
          break;
        case TextDirection.ltr:
          leftFraction = circle.horizontalLeadingOffset;
          break;
      }
      final Offset center =
          Offset(leftFraction * size.width, size.height / 2.0);
      final Tween<double> radiusTween = Tween<double>(
        begin: 0.0,
        end: _maxRadius(center, size),
      );
      canvas.drawCircle(
        center,
        radiusTween.transform(circle.animation.value),
        paint,
      );
    }
  }
}
