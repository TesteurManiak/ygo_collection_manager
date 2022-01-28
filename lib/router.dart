import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/error/exceptions.dart';
import 'presentation/blocs/db_version/db_version_bloc.dart';
import 'presentation/card_view/card_view.dart';
import 'presentation/expansion_view/expansion_view.dart';
import 'presentation/loading_view/loading_state_info.dart';
import 'presentation/loading_view/loading_view.dart';
import 'presentation/root_view/root_view.dart';
import 'service_locator.dart';

Widget _cardDetailsViewBuilder(
  BuildContext builderContext,
  GoRouterState state,
) {
  final cardId = state.params[CardView.routeParam];
  if (cardId == null) {
    throw const MissingRouteParamException('No card id');
  }
  return CardView(cardId: cardId);
}

GoRouter routerGenerator({
  String initialLocation = RootView.routePath,
  required LoadingStateInfo loadingState,
}) =>
    GoRouter(
      initialLocation: initialLocation,
      debugLogDiagnostics: true,
      redirect: (state) {
        final isLoading = state.location == LoadingView.routePath;
        final hasLoaded = loadingState.hasLoaded;

        if (!hasLoaded && !isLoading) return LoadingView.routePath;
        if (hasLoaded && isLoading) return RootView.routePath;
        return null;
      },
      refreshListenable: loadingState,
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
                return ExpansionView(setCode: setCode);
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
            child: LoadingView(state: loadingState),
          ),
        ),
      ],
      errorBuilder: (_, state) => Scaffold(
        body: Center(
          child: Text(state.error.toString(), textAlign: TextAlign.center),
        ),
      ),
    );
