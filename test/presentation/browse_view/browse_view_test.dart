import 'dart:ui' as ui;

import 'package:device_sizes/device_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';
import 'package:ygo_collection_manager/presentation/blocs/cards/cards_bloc.dart';
import 'package:ygo_collection_manager/presentation/browse_view/browse_view.dart';

import '../../utils/widgets.dart';
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
    testGoldens('Golden: Galaxy S20 FE', (tester) async {
      // arrange
      tester.binding.window.physicalSizeTestValue = ui.Size(
        galaxy_s20_fe.pixelResolution.height.toDouble(),
        galaxy_s20_fe.pixelResolution.width.toDouble(),
      );

      // act
      await tester.pumpWidget(
        BlocProvider(
          create: (_) => cardsBloc,
          child: createApp(child: const BrowseView()),
        ),
      );

      // assert
      await screenMatchesGolden(tester, 'browse_view_galaxy_s20_fe');
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });
  });
}
