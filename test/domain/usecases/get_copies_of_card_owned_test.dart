import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/usecases/get_copies_of_card_owned.dart';

import '../../utils/mocks.dart';

void main() {
  late MockYgoProRepository mockRepository;
  late GetCopiesOfCardOwned useCase;

  setUp(() {
    mockRepository = MockYgoProRepository();
    useCase = GetCopiesOfCardOwned(mockRepository);
  });

  group('GetCopiesOfCardOwned', () {
    const tNumberOfCards = 0;
    const tCardId = '';

    test('Should call getCopiesOfCardOwned from the repository', () async {
      // arrange
      when(() => mockRepository.getCopiesOfCardOwned(tCardId))
          .thenAnswer((_) async => tNumberOfCards);

      // act
      final result = await useCase(tCardId);

      // assert
      verify(() => mockRepository.getCopiesOfCardOwned(tCardId));
      expect(result, tNumberOfCards);
    });
  });
}
