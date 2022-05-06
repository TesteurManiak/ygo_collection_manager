import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/entities/card_edition_enum.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/usecases/update_card_owned.dart';

import '../../utils/mocks.dart';

void main() {
  late MockYgoProRepository mockRepository;
  late UpdateCardOwned useCase;

  setUp(() {
    mockRepository = MockYgoProRepository();
    useCase = UpdateCardOwned(mockRepository);
  });

  group('UpdateCardOwned', () {
    const tCard = CardOwned(
      quantity: 1,
      setCode: "",
      edition: CardEditionEnum.first,
      setName: "",
      id: 0,
    );

    test('Should call updateCardOwned from the repository', () async {
      // arrange
      when(() => mockRepository.updateCardOwned(tCard))
          .thenAnswer((_) async {});

      // act
      await useCase(tCard);

      // assert
      verify(() => mockRepository.updateCardOwned(tCard));
    });
  });
}
