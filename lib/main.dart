import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ygo_collection_manager/data/datasources/local/ygopro_local_datasource.dart';

import 'blocs/cards_bloc.dart';
import 'blocs/db_version_bloc.dart';
import 'blocs/expansion_collection_bloc.dart';
import 'blocs/sets_bloc.dart';
import 'core/bloc/bloc.dart';
import 'core/bloc/bloc_provider.dart';
import 'dynamic_theme/dynamic_theme.dart';
import 'service_locator.dart';
import 'styles/themes.dart';
import 'ui/loading_view/loading_view.dart';
import 'utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await locator<YgoProLocalDataSource>().init();
  runApp(
    BlocProvider(
      key: GlobalKey(),
      blocs: <BlocBase>[
        SetsBloc(),
        CardsBloc(),
        DBVersionBloc(),
        ExpansionCollectionBloc(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _systemBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultThemeMode: _systemBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      data: (themeMode) => MyThemes.fromThemeMode(themeMode, _systemBrightness),
      themedWidgetBuilder: (_, theme) => MaterialApp(
        theme: theme,
        initialRoute: LoadingView.routeName,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
