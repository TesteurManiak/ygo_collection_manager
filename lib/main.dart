import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'core/bloc/bloc.dart';
import 'core/bloc/bloc_provider.dart';
import 'core/router/router.dart';
import 'core/styles/themes.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'presentation/blocs/cards_bloc.dart';
import 'presentation/blocs/db_version_bloc.dart';
import 'presentation/blocs/expansion_collection_bloc.dart';
import 'presentation/blocs/sets_bloc.dart';
import 'presentation/loading_view/loading_view.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await sl<YgoProLocalDataSource>().initDb();

  runApp(
    BlocProvider(
      key: GlobalKey(),
      blocs: <BlocBase>[
        SetsBloc(fetchSets: sl()),
        CardsBloc(fetchCards: sl(), fetchOwnedCards: sl()),
        DBVersionBloc(shouldReloadDb: sl()),
        ExpansionCollectionBloc(
          getCopiesOfCardOwned: sl(),
          updateCardOwned: sl(),
        ),
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
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themedWidgetBuilder: (_, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          darkTheme: MyThemes.dark,
          theme: MyThemes.light,
          initialRoute: LoadingView.routeName,
          onGenerateRoute: generateRoute,
        );
      },
    );
  }
}
