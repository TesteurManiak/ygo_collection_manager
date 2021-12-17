import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/bloc/bloc.dart';
import 'core/bloc/bloc_provider.dart';
import 'core/styles/themes.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'presentation/blocs/cards_bloc.dart';
import 'presentation/blocs/db_version_bloc.dart';
import 'presentation/blocs/expansion_collection_bloc.dart';
import 'presentation/blocs/sets_bloc.dart';
import 'presentation/root_view/root_view.dart';
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
      themedWidgetBuilder: (_, themeMode, __) {
        return MaterialApp.router(
          themeMode: themeMode,
          darkTheme: MyThemes.dark,
          theme: MyThemes.light,
          // initialRoute: LoadingView.routeName,
          // onGenerateRoute: generateRoute,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        );
      },
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const RootView(),
      ),
    ),
  ],
  errorPageBuilder: (_, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString(), textAlign: TextAlign.center),
      ),
    ),
  ),
);
