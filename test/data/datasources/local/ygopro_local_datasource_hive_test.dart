import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/entities/db_version.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';

import 'ygopro_local_datasource_hive_test.mocks.dart';

class MockYgoCardBox extends MockBox<YgoCard> {}

class MockYgoSetBox extends MockBox<YgoSet> {}

class MockDbVersionBox extends MockBox<DbVersion> {}

class MockCardOwnedBox extends MockBox<CardOwned> {}

@GenerateMocks([HiveInterface, Box])
void main() {
  final mockHiveInterface = MockHiveInterface();
  final mockYgoCardBox = MockYgoCardBox();
  final mockYgoSetBox = MockYgoSetBox();
  final mockDbVersionBox = MockDbVersionBox();
  final mockCardOwnedBox = MockCardOwnedBox();

  final dataSource = YgoProLocalDataSourceHive(hive: mockHiveInterface);

  group('initDb', () {
    test('should register adapters and open the boxes', () async {
      // arrange
      when(mockHiveInterface.registerAdapter(any)).thenAnswer((_) {});
      when(
        mockHiveInterface
            .openBox<YgoCard>(YgoProLocalDataSourceHive.tableCards),
      ).thenAnswer((_) async => mockYgoCardBox);
      when(
        mockHiveInterface.openBox<YgoSet>(YgoProLocalDataSourceHive.tableSets),
      ).thenAnswer((_) async => mockYgoSetBox);
      when(
        mockHiveInterface.openBox<DbVersion>(YgoProLocalDataSourceHive.tableDB),
      ).thenAnswer((_) async => mockDbVersionBox);
      when(
        mockHiveInterface
            .openBox<CardOwned>(YgoProLocalDataSourceHive.tableCardsOwned),
      ).thenAnswer((_) async => mockCardOwnedBox);

      // act
      await dataSource.initDb();

      // assert
      verify(mockHiveInterface.registerAdapter(any));
      verify(
        mockHiveInterface
            .openBox<YgoCard>(YgoProLocalDataSourceHive.tableCards),
      );
      verify(
        mockHiveInterface.openBox<YgoSet>(YgoProLocalDataSourceHive.tableSets),
      );
      verify(
        mockHiveInterface.openBox<DbVersion>(YgoProLocalDataSourceHive.tableDB),
      );
      verify(
        mockHiveInterface
            .openBox<CardOwned>(YgoProLocalDataSourceHive.tableCardsOwned),
      );
    });
  });

  group('closeDb', () {
    test('should call close from the hive instance', () async {
      // arrange
      when(mockHiveInterface.close()).thenAnswer((_) async => true);

      // act
      await dataSource.closeDb();

      // assert
      verify(mockHiveInterface.close());
    });
  });

  group('getCards', () {
    final tCards = <YgoCard>[];

    test('should return the local values', () async {
      // arrange
      when(mockYgoCardBox.values).thenAnswer((_) => tCards);

      // act
      final cards = await dataSource.getCards();

      // assert
      verify(mockYgoCardBox.values);
      expect(cards, tCards);
    });
  });

  group('getDatabaseVersion', () {});

  group('getSets', () {});
}
