import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/loading_view/loading_state_info.dart';
import 'package:ygo_collection_manager/presentation/loading_view/loading_view.dart';
import 'package:ygo_collection_manager/presentation/root_view/root_view.dart';
import 'package:ygo_collection_manager/router.dart';
import 'package:ygo_collection_manager/service_locator.dart';

import '../utils/pump_real_router.dart';

void main() {
  setUpAll(setupLocator);

  testWidgets('render RootView via Router', (tester) async {
    final loadingState = LoadingStateInfo()..finishedLoading();
    await tester.pumpRealRouterApp(
      Routes.root,
      (child) => child,
      loadingState,
    );

    expect(loadingState.hasLoaded, true);
    expect(find.byType(RootView), findsOneWidget);

    loadingState.dispose();
  });

  testWidgets("render LoadingView via Router", (tester) async {
    final loadingState = LoadingStateInfo();
    await tester.pumpRealRouterApp(
      Routes.loading,
      (child) => child,
      loadingState,
    );

    expect(loadingState.hasLoaded, false);
    expect(find.byType(LoadingView), findsOneWidget);

    loadingState.dispose();
  });
}
