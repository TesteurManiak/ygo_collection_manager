import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ThemedWidgetBuilder = Widget Function(BuildContext, ThemeData);

typedef ThemeDataWithThemeModeBuilder = ThemeData Function(ThemeMode themeMode);

extension ThemeModeMofifier on ThemeMode {
  String get string => toString().split('.').last;
}

extension StringModifier on String {
  ThemeMode toThemeMode() {
    switch (this) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        throw Exception('Unknown theme mode: $this');
    }
  }
}

class DynamicTheme extends StatefulWidget {
  const DynamicTheme({
    Key? key,
    required this.data,
    required this.themedWidgetBuilder,
    this.defaultThemeMode = ThemeMode.light,
    this.loadThemeOnStart = true,
  }) : super(key: key);

  /// Builder that gets called when the theme changes.
  final ThemedWidgetBuilder themedWidgetBuilder;

  /// Callback that returns the latest theme.
  final ThemeDataWithThemeModeBuilder data;

  /// The default theme on start
  ///
  /// Defaults to `ThemeMode.light`
  final ThemeMode defaultThemeMode;

  /// Whether or not to load the brightness on start
  ///
  /// Defaults to `true`
  final bool loadThemeOnStart;

  @override
  DynamicThemeState createState() => DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.findAncestorStateOfType<DynamicThemeState>()!;
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  late ThemeData _themeData;

  ThemeMode _themeMode = ThemeMode.light;
  bool _shouldLoadBrightness = true;

  static const _sharedPreferencesKey = 'themeMode';

  /// Get the current `ThemeData`.
  ThemeData get themeData => _themeData;

  /// Get the current `ThemeMode`.
  ThemeMode get themeMode => _themeMode;

  @override
  void initState() {
    super.initState();
    _initVariables();
    _loadThemeMode();
  }

  /// Loads the theme depending on the `loadThemeOnStart` value.
  Future<void> _loadThemeMode() async {
    if (!_shouldLoadBrightness) {
      return;
    }
    final myThemeMode = await _getThemeMode();
    _themeMode = myThemeMode;
    _themeData = widget.data(_themeMode);
    if (mounted) {
      setState(() {});
    }
  }

  /// Initializes the variables.
  void _initVariables() {
    _themeMode = widget.defaultThemeMode;
    _themeData = widget.data(_themeMode);
    _shouldLoadBrightness = widget.loadThemeOnStart;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = widget.data(_themeMode);
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    _themeData = widget.data(_themeMode);
  }

  /// Sets the new theme
  /// Rebuilds the tree
  Future<void> setBrightness(ThemeMode themeMode) async {
    // Update state with new values
    setState(() {
      _themeData = widget.data(themeMode);
      _themeMode = themeMode;
    });
    await _saveThemeMode(themeMode);
  }

  /// Toggles the brightness from dark to light
  Future<void> toggleBrightness() async {
    // If brightness is dark, set it to light
    // If it's not dark, set it to dark
    if (_themeMode == ThemeMode.dark) {
      await setBrightness(ThemeMode.light);
    } else {
      await setBrightness(ThemeMode.dark);
    }
  }

  /// Changes the theme using the provided `ThemeData`
  void setThemeData(ThemeData data) {
    setState(() => _themeData = data);
  }

  /// Saves the provided themeMode in `SharedPreferences`
  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    //! Shouldn't save the brightness if you don't want to load it
    if (!_shouldLoadBrightness) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sharedPreferencesKey, themeMode.string);
  }

  /// Returns a [ThemeMode] that gives you the latest brightness.
  Future<ThemeMode> _getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Gets the ThemeMode stored in prefs
    // Or returns the `defaultThemeMode`
    return prefs.getString(_sharedPreferencesKey)?.toThemeMode() ??
        widget.defaultThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _themeData);
  }
}
