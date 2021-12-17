import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/themes.dart';

class _ThemeChoice {
  final String name;
  final ThemeMode mode;

  const _ThemeChoice({required this.name, required this.mode});
}

const _themeItems = <_ThemeChoice>[
  _ThemeChoice(name: 'Light', mode: ThemeMode.light),
  _ThemeChoice(name: 'Dark', mode: ThemeMode.dark),
  _ThemeChoice(name: 'System', mode: ThemeMode.system),
];

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late _ThemeChoice _themeChoice = _themeItems
      .firstWhere((item) => item.mode == DynamicTheme.of(context).themeMode);

  void _changeBrightness(_ThemeChoice? themeChoice) {
    if (themeChoice == null) return;
    setState(() => _themeChoice = themeChoice);
    MyThemes.changeBrightness(
      context,
      themeMode: _themeChoice.mode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Consts.px20),
            topRight: Radius.circular(Consts.px20),
          ),
        ),
        child: ListView(
          padding: MyEdgeInsets.all16,
          children: [
            Row(
              children: [
                const Icon(Icons.light_mode),
                const SizedBox(width: Consts.px8),
                const Text('Theme'),
                const SizedBox(width: Consts.px16),
                Expanded(
                  child: DropdownButton<_ThemeChoice>(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
