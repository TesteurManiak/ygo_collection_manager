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
import 'presentation/expansion_view/expansion_view.dart';
import 'presentation/loading_view/loading_state.dart';
import 'presentation/loading_view/loading_view.dart';
import 'presentation/root_view/root_view.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await sl<YgoProLocalDataSource>().initDb();

  // Turn off the # in the URLs on the web.
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

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
  final _loadingState = LoadingState();

  late final _router = GoRouter(
    redirect: (state) {
      final hasLoaded = _loadingState.hasLoaded;
      final isLoadingPath = state.location == '/loading';

      if (!hasLoaded && !isLoadingPath) return '/loading';
      if (hasLoaded && isLoadingPath) return '/home';
    },
    routes: [
      GoRoute(
        name: RootView.routeName,
        path: '/home',
        pageBuilder: (_, state) => MaterialPage(
          key: state.pageKey,
          child: const RootView(),
        ),
        routes: [
          GoRoute(
            name: ExpansionView.routeName,
            path: ':id',
            pageBuilder: (context, state) {
              final cardSet = BlocProvider.of<SetsBloc>(context)
                  .sets
                  .firstWhere((e) => e.setCode == state.params['id']);
              return MaterialPage(
                key: state.pageKey,
                child: ExpansionView(cardSet: cardSet),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/loading',
        pageBuilder: (_, state) => MaterialPage(
          key: state.pageKey,
          child: LoadingView(state: _loadingState),
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

  @override
  void dispose() {
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
