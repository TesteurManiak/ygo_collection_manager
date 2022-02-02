import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/domain/entities/card_edition_enum.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/update_card_owned.dart';

import 'update_card_owned_test.mocks.dart';

@GenerateMocks([YgoProRepository])
void main() {
  final mockRepository = MockYgoProRepository();

  final useCase = UpdateCardOwned(mockRepository);

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
      when(mockRepository.updateCardOwned(any)).thenAnswer((_) async {});

      // act
      await useCase(tCard);

      // assert
      verify(mockRepository.updateCardOwned(tCard));
    });
  });
}
