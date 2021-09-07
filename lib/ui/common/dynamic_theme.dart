import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData data);

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
    this.loadBrightnessOnStart = true,
  }) : super(key: key);

  /// Builder that gets called when the brightness or theme changes
  final ThemedWidgetBuilder themedWidgetBuilder;

  /// Callback that returns the latest brightness
  final ThemeDataWithThemeModeBuilder data;

  /// The default theme on start
  ///
  /// Defaults to `ThemeMode.light`
  final ThemeMode defaultThemeMode;

  /// Whether or not to load the brightness on start
  ///
  /// Defaults to `true`
  final bool loadBrightnessOnStart;

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

  static const String _sharedPreferencesKey = 'themeMode';

  /// Get the current `ThemeData`
  ThemeData get themeData => _themeData;

  /// Get the current `Brightness`
  ThemeMode get themeMode => _themeMode;

  @override
  void initState() {
    super.initState();
    _initVariables();
    _loadBrightness();
  }

  /// Loads the brightness depending on the `loadBrightnessOnStart` value
  Future<void> _loadBrightness() async {
    if (!_shouldLoadBrightness) {
      return;
    }
    final myThemeMode = await _getBrightness();
    _themeMode = myThemeMode;
    _themeData = widget.data(_themeMode);
    if (mounted) {
      setState(() {});
    }
  }

  /// Initializes the variables
  void _initVariables() {
    _themeMode = widget.defaultThemeMode;
    _themeData = widget.data(_themeMode);
    _shouldLoadBrightness = widget.loadBrightnessOnStart;
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

  /// Sets the new brightness
  /// Rebuilds the tree
  Future<void> setBrightness(ThemeMode themeMode) async {
    // Update state with new values
    setState(() {
      _themeData = widget.data(themeMode);
      _themeMode = themeMode;
    });
    // Save the brightness
    await _saveBrightness(themeMode);
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
    setState(() {
      _themeData = data;
    });
  }

  /// Saves the provided brightness in `SharedPreferences`
  Future<void> _saveBrightness(ThemeMode themeMode) async {
    //! Shouldn't save the brightness if you don't want to load it
    if (!_shouldLoadBrightness) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Saves whether or not the provided brightness is dark
    await prefs.setString(_sharedPreferencesKey, themeMode.string);
  }

  /// Returns a boolean that gives you the latest brightness
  Future<ThemeMode> _getBrightness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Gets the bool stored in prefs
    // Or returns whether or not the `defaultBrightness` is dark
    return prefs.getString(_sharedPreferencesKey)?.toThemeMode() ??
        widget.defaultThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _themeData);
  }
}
