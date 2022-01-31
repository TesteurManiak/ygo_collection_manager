import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_sets.dart';

import 'fetch_all_cards_test.mocks.dart';

@GenerateMocks([YgoProRepository])
void main() {
  final mockRepository = MockYgoProRepository();

  final useCase = FetchAllSets(mockRepository);

  group('FetchAllSets', () {
    const tShouldReload = false;
    const tSets = <YgoSet>[];

    test('Should call getAllSets from the repository', () async {
      // arrange
      when(mockRepository.getAllSets(shouldReload: tShouldReload))
          .thenAnswer((_) async => tSets);

      // act
      final result = await useCase(shouldReload: tShouldReload);

      // assert
      verify(mockRepository.getAllSets(shouldReload: tShouldReload));
      expect(result, tSets);
    });
  });
}
