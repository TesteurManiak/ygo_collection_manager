import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'package:ygo_collection_manager/data/models/response/db_version_model.dart';
import 'package:ygo_collection_manager/domain/entities/card_banlist_info.dart';
import 'package:ygo_collection_manager/domain/entities/card_edition_enum.dart';
import 'package:ygo_collection_manager/domain/entities/card_images.dart';
import 'package:ygo_collection_manager/domain/entities/card_misc_info.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/entities/card_price.dart';
import 'package:ygo_collection_manager/domain/entities/card_set.dart';
import 'package:ygo_collection_manager/domain/entities/db_version.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';

import '../../../utils/mocks.dart';

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
      whenRegisterBoxes(mockHiveInterface);
      when(
        () => mockHiveInterface
            .openBox<YgoCard>(YgoProLocalDataSourceHive.tableCards),
      ).thenAnswer((_) async => mockYgoCardBox);
      when(
        () => mockHiveInterface
            .openBox<YgoSet>(YgoProLocalDataSourceHive.tableSets),
      ).thenAnswer((_) async => mockYgoSetBox);
      when(
        () => mockHiveInterface
            .openBox<DbVersion>(YgoProLocalDataSourceHive.tableDB),
      ).thenAnswer((_) async => mockDbVersionBox);
      when(
        () => mockHiveInterface
            .openBox<CardOwned>(YgoProLocalDataSourceHive.tableCardsOwned),
      ).thenAnswer((_) async => mockCardOwnedBox);

      // act
      await dataSource.initDb();

      // assert
      verifyBoxes(mockHiveInterface);
      verify(
        () => mockHiveInterface
            .openBox<YgoCard>(YgoProLocalDataSourceHive.tableCards),
      );
      verify(
        () => mockHiveInterface
            .openBox<YgoSet>(YgoProLocalDataSourceHive.tableSets),
      );
      verify(
        () => mockHiveInterface
            .openBox<DbVersion>(YgoProLocalDataSourceHive.tableDB),
      );
      verify(
        () => mockHiveInterface
            .openBox<CardOwned>(YgoProLocalDataSourceHive.tableCardsOwned),
      );
    });
  });

  group('closeDb', () {
    test('should call close from the hive instance', () async {
      // arrange
      when(mockHiveInterface.close).thenAnswer((_) async => true);

      // act
      await dataSource.closeDb();

      // assert
      verify(mockHiveInterface.close);
    });
  });

  group('getCards', () {
    final tCards = <YgoCard>[];

    test('should return the local values', () async {
      // arrange
      when(() => mockYgoCardBox.values).thenReturn(tCards);

      // act
      final cards = await dataSource.getCards();

      // assert
      verify(() => mockYgoCardBox.values);
      expect(cards, tCards);
    });
  });

  group('getDatabaseVersion', () {
    final tDbVersion = DbVersionModel(
      lastUpdate: DateTime.now(),
      version: '1',
    );

    test('should check if box is empty and return null if true', () async {
      // arrange
      when(() => mockDbVersionBox.isEmpty).thenReturn(true);

      // act
      final version = await dataSource.getDatabaseVersion();

      // assert
      verify(() => mockDbVersionBox.isEmpty);
      expect(version, null);
    });

    test('should return local data if box is not empty', () async {
      // arrange
      when(() => mockDbVersionBox.isEmpty).thenReturn(false);
      when(() => mockDbVersionBox.values).thenReturn([tDbVersion]);

      // act
      final version = await dataSource.getDatabaseVersion();

      // assert
      verify(() => mockDbVersionBox.isEmpty);
      verify(() => mockDbVersionBox.values);
      expect(version, tDbVersion);
    });
  });

  group('getSets', () {
    final tSets = <YgoSet>[];

    test('should return the local values', () async {
      // arrange
      when(() => mockYgoSetBox.values).thenReturn(tSets);

      // act
      final sets = await dataSource.getSets();

      // assert
      verify(() => mockYgoSetBox.values);
      expect(sets, tSets);
    });
  });

  group('updateCards', () {
    final tCardsMap = <dynamic, YgoCard>{};
    final tCards = <YgoCard>[];

    test('should call putAll from the cardsBox', () async {
      // arrange
      when(() => mockYgoCardBox.putAll(tCardsMap))
          .thenAnswer((_) async => true);

      // act
      await dataSource.updateCards(tCards);

      // assert
      verify(() => mockYgoCardBox.putAll(tCardsMap));
    });
  });

  group('updateDbVersion', () {
    final tDbVersion = DbVersionModel(
      lastUpdate: DateTime.now(),
      version: '1',
    );

    test(
      'should call put on key 0 if no previous version is recorded',
      () async {
        // arrange
        when(() => mockDbVersionBox.isEmpty).thenReturn(true);
        when(() => mockDbVersionBox.put(0, tDbVersion))
            .thenAnswer((_) async => true);

        // act
        await dataSource.updateDbVersion(tDbVersion);

        // assert
        verify(() => mockDbVersionBox.isEmpty);
        verify(() => mockDbVersionBox.put(0, tDbVersion));
      },
    );

    test(
      'should call putAt on key 0 if previous version is recorded',
      () async {
        // arrange
        when(() => mockDbVersionBox.isEmpty).thenReturn(false);
        when(() => mockDbVersionBox.putAt(0, tDbVersion))
            .thenAnswer((_) async => true);

        // act
        await dataSource.updateDbVersion(tDbVersion);

        // assert
        verify(() => mockDbVersionBox.isEmpty);
        verify(() => mockDbVersionBox.putAt(0, tDbVersion));
      },
    );
  });

  group('updateSets', () {
    final tSets = <YgoSet>[];
    final tSetsMap = <dynamic, YgoSet>{};

    test('should call putAll from the setsBox', () async {
      // arrange
      when(() => mockYgoSetBox.putAll(tSetsMap)).thenAnswer((_) async => true);

      // act
      await dataSource.updateSets(tSets);

      // assert
      verify(() => mockYgoSetBox.putAll(tSetsMap));
    });
  });

  group('getCardsOwned', () {
    final tCardsOwned = <CardOwned>[];

    test('should return the local values', () async {
      // arrange
      when(() => mockCardOwnedBox.values).thenReturn(tCardsOwned);

      // act
      final cardsOwned = await dataSource.getCardsOwned();

      // assert
      verify(() => mockCardOwnedBox.values);
      expect(cardsOwned, tCardsOwned);
    });
  });

  group('getCopiesOfCardOwned', () {
    const tCardOwned = CardOwned(
      edition: CardEditionEnum.first,
      id: 1,
      quantity: 1,
      setCode: '',
      setName: '',
    );

    test('should return the number of copies owned', () async {
      // arrange
      when(() => mockCardOwnedBox.get(tCardOwned.key)).thenReturn(tCardOwned);

      // act
      final copiesOwned = await dataSource.getCopiesOfCardOwned(tCardOwned.key);

      // assert
      verify(() => mockCardOwnedBox.get(tCardOwned.key));
      expect(copiesOwned, tCardOwned.quantity);
    });
  });

  group('getCopiesOfCardOwnedById', () {
    const tCardOwned = CardOwned(
      edition: CardEditionEnum.first,
      id: 1,
      quantity: 1,
      setCode: '',
      setName: '',
    );

    test('should return the number of copies owned', () async {
      // arrange
      when(() => mockCardOwnedBox.values).thenReturn([tCardOwned]);

      // act
      final copiesOwned =
          await dataSource.getCopiesOfCardOwnedById(tCardOwned.id);

      // assert
      verify(() => mockCardOwnedBox.values);
      expect(copiesOwned, tCardOwned.quantity);
    });
  });

  group('updateCardOwned', () {
    const tKeyIndex = 0;

    const tCardOwned = CardOwned(
      edition: CardEditionEnum.first,
      id: 1,
      quantity: 1,
      setCode: '',
      setName: '',
    );

    test(
      'should call put on the cardOwnedBox if card does not exists',
      () async {
        // arrange
        when(() => mockCardOwnedBox.keys).thenReturn([]);
        when(() => mockCardOwnedBox.put(tCardOwned.key, tCardOwned))
            .thenAnswer((_) async => true);

        // act
        await dataSource.updateCardOwned(tCardOwned);

        // assert
        verify(() => mockCardOwnedBox.keys);
        verify(() => mockCardOwnedBox.put(tCardOwned.key, tCardOwned));
      },
    );

    test('should call putAt on the cardOwnedBox if card exists', () async {
      // arrange
      when(() => mockCardOwnedBox.keys).thenReturn([tCardOwned.key]);
      when(() => mockCardOwnedBox.putAt(tKeyIndex, tCardOwned))
          .thenAnswer((_) async => true);

      // act
      await dataSource.updateCardOwned(tCardOwned);

      // assert
      verify(() => mockCardOwnedBox.keys);
      verify(() => mockCardOwnedBox.putAt(tKeyIndex, tCardOwned));
    });
  });

  group('removeCard', () {
    const tCardOwned = CardOwned(
      edition: CardEditionEnum.first,
      id: 1,
      quantity: 1,
      setCode: '',
      setName: '',
    );

    test('should call delete from the cardOwnedBox', () async {
      // arrange
      when(() => mockCardOwnedBox.delete(tCardOwned.key))
          .thenAnswer((_) async => true);

      // act
      await dataSource.removeCard(tCardOwned);

      // assert
      verify(() => mockCardOwnedBox.delete(tCardOwned.key));
    });
  });
}

void whenRegisterBoxes(MockHiveInterface mockHiveInterface) {
  when(
    () => mockHiveInterface.registerAdapter<DbVersion>(DbVersionAdapter()),
  ).thenAnswer((_) {});

  when(() => mockHiveInterface.registerAdapter<YgoCard>(YgoCardAdapter()))
      .thenAnswer((_) {});
  when(
    () => mockHiveInterface.registerAdapter<CardImages>(CardImagesAdapter()),
  ).thenAnswer((_) {});
  when(() => mockHiveInterface.registerAdapter<CardSet>(CardSetAdapter()))
      .thenAnswer((_) {});
  when(() => mockHiveInterface.registerAdapter<CardPrice>(CardPriceAdapter()))
      .thenAnswer((_) {});
  when(
    () => mockHiveInterface.registerAdapter<CardBanlistInfo>(
      CardBanlistInfoAdapter(),
    ),
  ).thenAnswer((_) {});
  when(
    () => mockHiveInterface.registerAdapter<CardMiscInfo>(
      CardMiscInfoAdapter(),
    ),
  ).thenAnswer((_) {});

  when(() => mockHiveInterface.registerAdapter<YgoSet>(YgoSetAdapter()))
      .thenAnswer((_) {});
  when(() => mockHiveInterface.registerAdapter<CardOwned>(CardOwnedAdapter()))
      .thenAnswer((_) {});
  when(
    () => mockHiveInterface.registerAdapter<CardEditionEnum>(
      CardEditionEnumAdapter(),
    ),
  ).thenAnswer((_) {});
}

void verifyBoxes(MockHiveInterface mockHiveInterface) {
  verify(
    () => mockHiveInterface.registerAdapter<DbVersion>(DbVersionAdapter()),
  );
  verify(() => mockHiveInterface.registerAdapter<YgoCard>(YgoCardAdapter()));
  verify(
    () => mockHiveInterface.registerAdapter<CardImages>(CardImagesAdapter()),
  );
  verify(() => mockHiveInterface.registerAdapter<CardSet>(CardSetAdapter()));
  verify(
    () => mockHiveInterface.registerAdapter<CardPrice>(CardPriceAdapter()),
  );
  verify(
    () => mockHiveInterface.registerAdapter<CardBanlistInfo>(
      CardBanlistInfoAdapter(),
    ),
  );
  verify(
    () => mockHiveInterface.registerAdapter<CardMiscInfo>(
      CardMiscInfoAdapter(),
    ),
  );
  verify(() => mockHiveInterface.registerAdapter<YgoSet>(YgoSetAdapter()));
  verify(
    () => mockHiveInterface.registerAdapter<CardOwned>(CardOwnedAdapter()),
  );
  verify(
    () => mockHiveInterface.registerAdapter<CardEditionEnum>(
      CardEditionEnumAdapter(),
    ),
  );
}
