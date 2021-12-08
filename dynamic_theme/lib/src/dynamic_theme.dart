import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:shared_preferences/shared_preferences.dart';

typedef ThemedWidgetBuilder = Widget Function(BuildContext, ThemeData);
typedef ThemeDataWithThemeModeBuilder = ThemeData Function(
  ThemeMode themeMode,
  Brightness? systemBrightness,
);

extension on ThemeMode {
  String get string => toString().split('.').last;
}

extension on String {
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

/// Creates a widget that applies a theme to a child widget. You can change the
/// theme by calling `setThemeMode`.
class DynamicTheme extends StatefulWidget {
  const DynamicTheme({
    Key? key,
    required this.data,
    required this.themedWidgetBuilder,
    this.defaultThemeMode = ThemeMode.system,
    this.loadThemeOnStart = true,
  }) : super(key: key);

  /// Builder that gets called when the theme changes.
  final ThemedWidgetBuilder themedWidgetBuilder;

  /// Callback that returns the latest theme.
  final ThemeDataWithThemeModeBuilder data;

  /// The default theme on start
  ///
  /// Defaults to `ThemeMode.system`
  final ThemeMode defaultThemeMode;

  /// Whether or not to load the theme on start.
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

  void _updateThemeData() {
    Brightness? systemBrightness;
    if (_themeMode == ThemeMode.system) {
      systemBrightness = SchedulerBinding.instance?.window.platformBrightness;
    }
    _themeData = widget.data(_themeMode, systemBrightness);
  }

  /// Loads the theme depending on the `loadThemeOnStart` value.
  Future<void> _loadThemeMode() async {
    if (!_shouldLoadBrightness) {
      return;
    }
    final myThemeMode = await _getThemeMode();
    _themeMode = myThemeMode;
    _updateThemeData();
    if (mounted) {
      setState(() {});
    }
  }

  /// Initializes the variables.
  void _initVariables() {
    _themeMode = widget.defaultThemeMode;
    _updateThemeData();
    _shouldLoadBrightness = widget.loadThemeOnStart;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateThemeData();
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateThemeData();
  }

  /// Sets the new theme
  /// Rebuilds the tree
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final _systemBrightness =
        SchedulerBinding.instance?.window.platformBrightness;

    // Update state with new values
    setState(() {
      _themeData = widget.data(themeMode, _systemBrightness);
      _themeMode = themeMode;
    });
    await _saveThemeMode(themeMode);
  }

  /// Toggles the brightness from dark to light
  Future<void> toggleBrightness() async {
    switch (_themeMode) {
      case ThemeMode.system:
        // If brightness is dark, set it to light
        // If it's not dark, set it to dark
        final b = Theme.of(context).brightness;
        if (b == Brightness.dark) {
          await setThemeMode(ThemeMode.light);
        } else {
          await setThemeMode(ThemeMode.dark);
        }
        break;
      case ThemeMode.light:
        await setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await setThemeMode(ThemeMode.light);
        break;
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
