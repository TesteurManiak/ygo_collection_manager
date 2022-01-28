import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/blocs/cards/cards_bloc.dart';
import 'package:ygo_collection_manager/presentation/blocs/sets/sets_bloc.dart';
import 'package:ygo_collection_manager/presentation/loading_view/loading_state_info.dart';
import 'package:ygo_collection_manager/router.dart';
import 'package:ygo_collection_manager/service_locator.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpRealRouterApp(
    String location,
    Widget Function(Widget child) builder,
    LoadingStateInfo loadingState,
  ) {
    final router = routerGenerator(
      initialLocation: location,
      loadingState: loadingState,
    );
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SetsBloc(fetchSets: sl())),
          BlocProvider(
            create: (_) => CardsBloc(fetchCards: sl(), fetchOwnedCards: sl()),
          ),
        ],
        child: builder(
          MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          ),
        ),
      ),
      const Duration(milliseconds: 3000),
    );
  }
}
