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
import 'presentation/card_view/card_view.dart';
import 'presentation/expansion_view/expansion_view.dart';
import 'presentation/loading_view/loading_state_info.dart';
import 'presentation/loading_view/loading_view.dart';
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
  final _loadingState = LoadingStateInfo();

  late final _router = GoRouter(
    initialLocation: '/home',
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
    redirect: (state) {
      final isLoading = state.location == '/loading';
      final hasLoaded = _loadingState.hasLoaded;

      if (!hasLoaded && !isLoading) return '/loading';
      if (hasLoaded && isLoading) return '/home';
      return null;
    },
    refreshListenable: _loadingState,
    routes: [
      GoRoute(
        name: RootView.routeName,
        path: '/home',
        builder: (_, __) => const RootView(),
        routes: [
          GoRoute(
            name: ExpansionView.routeName,
            path: ':setId',
            builder: (context, state) {
              final cardSet = BlocProvider.of<SetsBloc>(context)
                  .sets
                  .firstWhere((e) => e.setCode == state.params['setId']);
              return ExpansionView(cardSet: cardSet);
            },
            routes: [
              GoRoute(
                name: CardView.routeName,
                path: 'list/:cardId',
                builder: (context, state) {
                  final card =
                      BlocProvider.of<CardsBloc>(context).cards!.firstWhere(
                            (e) => e.id == int.parse(state.params['cardId']!),
                          );
                  return CardView(card: card);
                },
              ),
            ],
          ),
          GoRoute(
            name: CardView.alternateRouteName,
            path: '${CardView.alternateRouteName}/:cardId',
            builder: (context, state) {
              final card =
                  BlocProvider.of<CardsBloc>(context).cards!.firstWhere(
                        (e) => e.id == int.parse(state.params['cardId']!),
                      );
              return CardView(card: card);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/loading',
        builder: (_, __) => LoadingView(state: _loadingState),
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString(), textAlign: TextAlign.center),
      ),
    ),
  );

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
