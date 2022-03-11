import 'package:equatable/equatable.dart';
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
  final cardId = state.params[RouteParams.cardId];
  if (cardId == null) {
    throw const MissingRouteParamException('No card id');
  }
  return CardView(cardId: cardId);
}

GoRouter routerGenerator({
  String? initialLocation,
  required LoadingStateInfo loadingState,
}) =>
    GoRouter(
      initialLocation: initialLocation ?? Routes.root,
      debugLogDiagnostics: true,
      redirect: (state) {
        final isLoading = state.location == Routes.loading;
        final hasLoaded = loadingState.hasLoaded;

        if (!hasLoaded && !isLoading) return Routes.loading;
        if (hasLoaded && isLoading) return Routes.root;
        return null;
      },
      refreshListenable: loadingState,
      routes: [
        GoRoute(
          name: RootView.routeName,
          path: Routes.root,
          builder: (_, __) => const RootView(),
          routes: [
            GoRoute(
              name: ExpansionView.routeName,
              path: Routes.expansion,
              builder: (_, state) {
                final setCode = state.params[RouteParams.setCode];
                if (setCode == null) {
                  throw const MissingRouteParamException('No set code');
                }
                return ExpansionView(setCode: setCode);
              },
            ),
            GoRoute(
              name: CardView.routeName,
              path: Routes.card,
              builder: _cardDetailsViewBuilder,
            ),
          ],
        ),
        GoRoute(
          name: LoadingView.routeName,
          path: Routes.loading,
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

class Routes extends Equatable {
  static const loading = '/';
  static const root = '/home';
  static const expansion = 'set/:${RouteParams.setCode}';
  static const card = 'details/:${RouteParams.cardId}';

  @override
  List<Object?> get props => [root, loading, expansion, card];
}

abstract class RouteParams {
  static const setCode = 'setId';
  static const cardId = 'cardId';
}
