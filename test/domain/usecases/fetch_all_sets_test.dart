import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_sets.dart';

import '../../utils/mocks.dart';

void main() {
  late MockYgoProRepository mockRepository;
  late FetchAllSets useCase;

  setUp(() {
    mockRepository = MockYgoProRepository();
    useCase = FetchAllSets(mockRepository);
  });

  group('FetchAllSets', () {
    const tShouldReload = false;
    const tSets = <YgoSet>[];

    test('Should call getAllSets from the repository', () async {
      // arrange
      when(() => mockRepository.getAllSets(shouldReload: tShouldReload))
          .thenAnswer((_) async => tSets);

      // act
      final result = await useCase(shouldReload: tShouldReload);

      // assert
      verify(() => mockRepository.getAllSets(shouldReload: tShouldReload));
      expect(result, tSets);
    });
  });
}
