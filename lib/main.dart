import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/navigation_bloc.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/styles/themes.dart';
import 'package:ygo_collection_manager/ui/root_view/root_view.dart';

void main() {
  runApp(
    BlocProvider(
      key: GlobalKey(),
      blocs: <BlocBase>[
        NavigationBloc(),
        SetsBloc(),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _systemBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: _systemBrightness ?? Brightness.light,
      data: MyThemes.fromBrightness,
      themedWidgetBuilder: (_, theme) => MaterialApp(
        theme: theme,
        home: RootView(),
      ),
    );
  }
}
