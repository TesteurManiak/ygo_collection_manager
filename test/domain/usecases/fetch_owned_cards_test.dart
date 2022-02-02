import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';

import 'fetch_owned_cards_test.mocks.dart';

@GenerateMocks([YgoProRepository])
void main() {
  final mockRepository = MockYgoProRepository();
  final useCase = FetchOwnedCards(mockRepository);

  group('FetchOwnedCards', () {
    const tOwnedCards = <CardOwned>[];

    test('Should call getOwnedCards from the repository', () async {
      // arrange
      when(mockRepository.getOwnedCards()).thenAnswer((_) async => tOwnedCards);

      // act
      final result = await useCase();

      // assert
      verify(mockRepository.getOwnedCards());
      expect(result, tOwnedCards);
    });
  });
}
