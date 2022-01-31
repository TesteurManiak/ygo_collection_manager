import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';

import 'fetch_all_cards_test.mocks.dart';

@GenerateMocks([YgoProRepository])
void main() {
  final mockRepository = MockYgoProRepository();

  final useCase = FetchAllCards(mockRepository);

  group('FetchAllCards', () {
    const tShouldReload = false;
    const tCards = <YgoCard>[];

    test('Should call getAllCards from the repository', () async {
      // arrange
      when(mockRepository.getAllCards(shouldReload: tShouldReload))
          .thenAnswer((_) async => tCards);

      // act
      final result = await useCase(shouldReload: tShouldReload);

      // assert
      verify(mockRepository.getAllCards(shouldReload: tShouldReload));
      expect(result, tCards);
    });
  });
}
