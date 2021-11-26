import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:device_sizes/device_sizes.dart';
import 'package:mockito/annotations.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';
import 'package:ygo_collection_manager/presentation/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/presentation/browse_view/browse_view.dart';

import '../../utils/blocs_injector.dart';
import 'browse_view_test.mocks.dart';

@GenerateMocks([FetchAllCards, FetchOwnedCards])
void main() {
  final mockFetchCards = MockFetchAllCards();
  final mockFetchOwnedCards = MockFetchOwnedCards();

  final cardsBloc = CardsBloc(
    fetchCards: mockFetchCards,
    fetchOwnedCards: mockFetchOwnedCards,
  );

  setUp(() async {
    await loadAppFonts();
  });

  group('BrowseView', () {
    testWidgets('Pump widget with mocked CardsBloc', (tester) async {
      await tester.pumpWidget(
        createApp(
          blocs: [cardsBloc],
          child: const BrowseView(),
        ),
      );
    });

    testGoldens('Golden: Galaxy S20 FE', (tester) async {
      tester.binding.window.physicalSizeTestValue = ui.Size(
        galaxy_s20_fe.pixelResolution.width.toDouble(),
        galaxy_s20_fe.pixelResolution.height.toDouble(),
      );

      // await tester.pumpWidget(widget);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });
  });
}
