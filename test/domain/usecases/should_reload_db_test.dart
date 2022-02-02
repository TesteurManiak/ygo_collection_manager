import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/should_reload_db.dart';

import 'should_reload_db_test.mocks.dart';

@GenerateMocks([YgoProRepository])
void main() {
  final mockRepository = MockYgoProRepository();

  final useCase = ShouldReloadDb(mockRepository);

  group('ShouldReloadDb', () {
    const tShouldReload = false;

    test('Should call shouldReloadDb from the repository', () async {
      // arrange
      when(mockRepository.shouldReloadDb())
          .thenAnswer((_) async => tShouldReload);

      // act
      final result = await useCase();

      // assert
      verify(mockRepository.shouldReloadDb());
      expect(result, tShouldReload);
    });
  });
}
