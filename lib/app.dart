import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'presentation/constants/themes.dart';
import 'presentation/loading_view/loading_state_info.dart';
import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _loadingState = LoadingStateInfo();

  late final _router = routerGenerator(loadingState: _loadingState);

  @override
  void dispose() {
    _router.dispose();
    _loadingState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themedWidgetBuilder: (_, themeMode, __) {
        return MaterialApp.router(
          themeMode: themeMode,
          darkTheme: MyThemes.dark,
          theme: MyThemes.light,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        );
      },
    );
  }
}
