import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';

import '../../utils/mocks.dart';

void main() {
  late MockYgoProRepository mockRepository;
  late FetchOwnedCards useCase;

  setUp(() {
    mockRepository = MockYgoProRepository();
    useCase = FetchOwnedCards(mockRepository);
  });

  group('FetchOwnedCards', () {
    const tOwnedCards = <CardOwned>[];

    test('Should call getOwnedCards from the repository', () async {
      // arrange
      when(mockRepository.getOwnedCards).thenAnswer((_) async => tOwnedCards);

      // act
      final result = await useCase();

      // assert
      verify(mockRepository.getOwnedCards);
      expect(result, tOwnedCards);
    });
  });
}
