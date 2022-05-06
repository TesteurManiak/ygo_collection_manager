import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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

GoRouter routerGenerator({
  String? initialLocation,
  required LoadingStateInfo loadingState,
}) {
  return GoRouter(
    initialLocation: initialLocation ?? AppRoutePath.home,
    debugLogDiagnostics: kDebugMode,
    redirect: (state) {
      final isLoading = state.location == AppRoutePath.loading;
      final hasLoaded = loadingState.hasLoaded;

      if (!hasLoaded && !isLoading) return AppRoutePath.loading;
      if (hasLoaded && isLoading) return AppRoutePath.home;
      return null;
    },
    refreshListenable: loadingState,
    routes: [
      GoRoute(
        path: AppRoutePath.home,
        name: AppRouteName.home.name,
        builder: (_, __) => const RootView(),
        routes: [
          GoRoute(
            path: AppRoutePath.set,
            name: AppRouteName.set.name,
            builder: (_, state) {
              final setCode = state.params[AppRouteParams.setCode];
              if (setCode == null) {
                throw const MissingRouteParamException('No set code');
              }
              return ExpansionView(setCode: setCode);
            },
          ),
          GoRoute(
            path: AppRoutePath.details,
            name: AppRouteName.details.name,
            builder: _cardDetailsViewBuilder,
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePath.loading,
        name: AppRouteName.loading.name,
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
}

Widget _cardDetailsViewBuilder(
  BuildContext context,
  GoRouterState state,
) {
  final cardId = state.params[AppRouteParams.cardId];
  if (cardId == null) {
    throw const MissingRouteParamException('No card id');
  }
  return CardView(cardId: cardId);
}

enum AppRouteName { loading, home, set, details }

class AppRoutePath extends Equatable {
  static const loading = '/';
  static const home = '/home';
  static const set = 'set/:${AppRouteParams.setCode}';
  static const details = 'details/:${AppRouteParams.cardId}';

  @override
  List<Object?> get props => [home, loading, set, details];
}

class AppRouteParams extends Equatable {
  static const setCode = 'setId';
  static const cardId = 'cardId';

  @override
  List<Object?> get props => [setCode, cardId];
}
