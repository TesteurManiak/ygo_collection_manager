import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/error/exceptions.dart';
import 'presentation/blocs/cards/cards_bloc.dart';
import 'presentation/blocs/db_version/db_version_bloc.dart';
import 'presentation/blocs/sets/sets_bloc.dart';
import 'presentation/card_view/card_view.dart';
import 'presentation/constants/themes.dart';
import 'presentation/expansion_view/expansion_view.dart';
import 'presentation/loading_view/loading_state_info.dart';
import 'presentation/loading_view/loading_view.dart';
import 'presentation/root_view/root_view.dart';
import 'service_locator.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _loadingState = LoadingStateInfo();

  Widget _cardDetailsViewBuilder(
    BuildContext builderContext,
    GoRouterState state,
  ) {
    final cardId = state.params[CardView.routeParam];
    if (cardId == null) {
      throw const MissingRouteParamException('No card id');
    }
    final card =
        BlocProvider.of<CardsBloc>(builderContext).findCardFromParam(cardId);
    return CardView(card: card);
  }

  late final _router = GoRouter(
    initialLocation: RootView.routePath,
    debugLogDiagnostics: true,
    redirect: (state) {
      final isLoading = state.location == LoadingView.routePath;
      final hasLoaded = _loadingState.hasLoaded;

      if (!hasLoaded && !isLoading) return LoadingView.routePath;
      if (hasLoaded && isLoading) return RootView.routePath;
      return null;
    },
    refreshListenable: _loadingState,
    routes: [
      GoRoute(
        name: RootView.routeName,
        path: RootView.routePath,
        builder: (_, __) => const RootView(),
        routes: [
          GoRoute(
            name: ExpansionView.routeName,
            path: ExpansionView.routePath,
            builder: (context, state) {
              final setCode = state.params[ExpansionView.routeParam];
              if (setCode == null) {
                throw const MissingRouteParamException('No set code');
              }
              final cardSet =
                  BlocProvider.of<SetsBloc>(context).findSetFromCode(setCode);
              return ExpansionView(cardSet: cardSet);
            },
            routes: [
              GoRoute(
                name: CardView.routeName,
                path: CardView.routePath,
                builder: _cardDetailsViewBuilder,
              ),
            ],
          ),
          GoRoute(
            name: CardView.altRouteName,
            path: CardView.altRoutePath,
            builder: _cardDetailsViewBuilder,
          ),
        ],
      ),
      GoRoute(
        name: LoadingView.routeName,
        path: LoadingView.routePath,
        builder: (_, __) => BlocProvider(
          create: (_) => DBVersionBloc(shouldReloadDb: sl()),
          child: LoadingView(state: _loadingState),
        ),
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
