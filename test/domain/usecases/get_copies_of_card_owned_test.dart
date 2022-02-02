import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/get_copies_of_card_owned.dart';

import 'get_copies_of_card_owned_test.mocks.dart';

@GenerateMocks([YgoProRepository])
void main() {
  final mockRepository = MockYgoProRepository();
  final useCase = GetCopiesOfCardOwned(mockRepository);

  group('GetCopiesOfCardOwned', () {
    const tNumberOfCards = 0;
    const tCardId = '';

    test('Should call getCopiesOfCardOwned from the repository', () async {
      // arrange
      when(mockRepository.getCopiesOfCardOwned(any))
          .thenAnswer((_) async => tNumberOfCards);

      // act
      final result = await useCase(tCardId);

      // assert
      verify(mockRepository.getCopiesOfCardOwned(tCardId));
      expect(result, tNumberOfCards);
    });
  });
}
