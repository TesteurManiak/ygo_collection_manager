import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_sets.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/should_reload_db.dart';
import 'package:ygo_collection_manager/presentation/collection_view/collection_view.dart';
import 'package:ygo_collection_manager/presentation/loading_view/loading_state_info.dart';
import 'package:ygo_collection_manager/presentation/loading_view/loading_view.dart';
import 'package:ygo_collection_manager/presentation/root_view/root_view.dart';
import 'package:ygo_collection_manager/router.dart';
import 'package:ygo_collection_manager/service_locator.dart';

import '../utils/mocks.dart';
import '../utils/pump_real_router.dart';

void main() {
  final mockFetchAllSets = MockFetchAllSets();
  final mockFetchAllCards = MockFetchAllCards();
  final mockFetchOwnedCards = MockFetchOwnedCards();
  final mockShouldReloadDb = MockShouldReloadDb();

  setUp(() {
    // setup the locator
    sl.registerLazySingleton<FetchAllSets>(() => mockFetchAllSets);
    sl.registerLazySingleton<FetchAllCards>(() => mockFetchAllCards);
    sl.registerLazySingleton<FetchOwnedCards>(() => mockFetchOwnedCards);
    sl.registerLazySingleton<ShouldReloadDb>(() => mockShouldReloadDb);
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('render RootView via Router', (tester) async {
    // arrange
    final loadingState = LoadingStateInfo()..finishedLoading();

    // act
    await tester.pumpRealRouterApp(
      AppRoutePath.home,
      (child) => child,
      loadingState,
    );

    // assert
    expect(find.byType(RootView), findsOneWidget);
    expect(find.byType(CollectionView), findsOneWidget);

    loadingState.dispose();
  });

  testWidgets("render LoadingView via Router", (tester) async {
    // arrange
    when(mockShouldReloadDb).thenAnswer((_) async => false);
    final loadingState = LoadingStateInfo();

    // act
    await tester.pumpRealRouterApp(
      AppRoutePath.loading,
      (child) => child,
      loadingState,
    );

    // assert
    verify(mockShouldReloadDb);
    expect(find.byType(LoadingView), findsOneWidget);

    loadingState.dispose();
  });

  // testWidgets("redirect to ExpansionView", (tester) async {
  //   await tester.pumpRouterApp(const RootView());
  // });
}
