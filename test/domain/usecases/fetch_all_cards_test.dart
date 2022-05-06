import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';

import '../../utils/mocks.dart';

void main() {
  late MockYgoProRepository mockRepository;
  late FetchAllCards useCase;

  setUp(() {
    mockRepository = MockYgoProRepository();
    useCase = FetchAllCards(mockRepository);
  });

  group('FetchAllCards', () {
    const tShouldReload = false;
    const tCards = <YgoCard>[];

    test('Should call getAllCards from the repository', () async {
      // arrange
      when(() => mockRepository.getAllCards(shouldReload: tShouldReload))
          .thenAnswer((_) async => tCards);

      // act
      final result = await useCase(shouldReload: tShouldReload);

      // assert
      verify(() => mockRepository.getAllCards(shouldReload: tShouldReload));
      expect(result, tCards);
    });
  });
}
