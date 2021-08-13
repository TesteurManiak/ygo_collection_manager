import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/styles/themes.dart';

enum _ThemeMode { light, dark, system }

class _ThemeChoice {
  final String name;
  final _ThemeMode mode;

  Brightness brightness(BuildContext context) {
    if (mode == _ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness;
    }
    return mode == _ThemeMode.light ? Brightness.light : Brightness.dark;
  }

  const _ThemeChoice({
    required this.name,
    required this.mode,
  });
}

const _themeItems = <_ThemeChoice>[
  _ThemeChoice(name: 'Light', mode: _ThemeMode.light),
  _ThemeChoice(name: 'Dark', mode: _ThemeMode.dark),
  // _ThemeChoice(name: 'Set by System', mode: _ThemeMode.system),
];

class SettingsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late _ThemeChoice _themeChoice =
      Theme.of(context).brightness == Brightness.light
          ? _themeItems[0]
          : _themeItems[1];

  void _changeBrightness(_ThemeChoice? themeChoice) {
    if (themeChoice == null) return;
    setState(() {
      _themeChoice = themeChoice;
      MyThemes.changeBrightness(
        context,
        brightness: _themeChoice.brightness(context),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButton<_ThemeChoice>(
              value: _themeChoice,
              onChanged: _changeBrightness,
              items: _themeItems
                  .map<DropdownMenuItem<_ThemeChoice>>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
