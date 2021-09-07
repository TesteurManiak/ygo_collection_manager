import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/db_version_bloc.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/styles/themes.dart';
import 'package:ygo_collection_manager/ui/common/dynamic_theme.dart';
import 'package:ygo_collection_manager/ui/loading_view/loading_view.dart';
import 'package:ygo_collection_manager/utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.instance.initHive();
  runApp(
    BlocProvider(
      key: GlobalKey(),
      blocs: <BlocBase>[
        SetsBloc(),
        CardsBloc(),
        DBVersionBloc(),
        ExpansionCollectionBloc(),
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
      defaultBrightness: _systemBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      data: (themeMode) =>
          MyThemes.fromBrightness(themeMode, _systemBrightness),
      themedWidgetBuilder: (_, theme) => MaterialApp(
        theme: theme,
        initialRoute: LoadingView.routeName,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
