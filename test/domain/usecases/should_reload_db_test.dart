import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/domain/usecases/should_reload_db.dart';

import '../../utils/mocks.dart';

void main() {
  late MockYgoProRepository mockRepository;
  late ShouldReloadDb useCase;

  setUp(() {
    mockRepository = MockYgoProRepository();
    useCase = ShouldReloadDb(mockRepository);
  });

  group('ShouldReloadDb', () {
    const tShouldReload = false;

    test('Should call shouldReloadDb from the repository', () async {
      // arrange
      when(mockRepository.shouldReloadDb)
          .thenAnswer((_) async => tShouldReload);

      // act
      final result = await useCase();

      // assert
      verify(mockRepository.shouldReloadDb);
      expect(result, tShouldReload);
    });
  });
}
