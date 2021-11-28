import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/core/entities/card_edition_enum.dart';
import 'package:ygo_collection_manager/core/platform/network_info.dart';
import 'package:ygo_collection_manager/data/datasources/local/ygopro_local_datasource.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/request/get_card_info_request.dart';
import 'package:ygo_collection_manager/data/models/response/db_version_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_set_model.dart';
import 'package:ygo_collection_manager/data/repository/ygopro_repository_impl.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';

import 'ygopro_repository_impl_test.mocks.dart';

@GenerateMocks([YgoProRemoteDataSource, YgoProLocalDataSource, NetworkInfo])
void main() {
  final mockRemoteDataSource = MockYgoProRemoteDataSource();
  final mockLocalDataSource = MockYgoProLocalDataSource();
  final mockNetworkInfo = MockNetworkInfo();

  final repository = YgoProRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  final tCards = List<YgoCard>.generate(
    10,
    (index) => YgoCardModel(
      id: index,
      name: 'name: $index',
      type: 'type: $index',
      desc: 'desc: $index',
      atk: null,
      def: null,
      level: null,
      race: 'race: $index',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: const [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: const [],
      banlistInfo: null,
      miscInfo: const [],
    ),
  );

  group('getAllSets', () {
    final tSets = <YgoSetModel>[
      const YgoSetModel(
        setName: '',
        setCode: '',
        numOfCards: 0,
        tcgDate: null,
      ),
    ];

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getSets()).thenAnswer((_) async => []);

      // act
      repository.getAllSets(shouldReload: false);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('if offline fetch from local datasource', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getSets()).thenAnswer((_) async => tSets);

      // act
      final sets = await repository.getAllSets(shouldReload: false);

      // assert
      verify(mockLocalDataSource.getSets());
      expect(sets, tSets);
    });

    test('if online fetch from remote datasource', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllSets()).thenAnswer((_) async => tSets);

      // act
      final sets = await repository.getAllSets(shouldReload: true);

      // assert
      verify(mockRemoteDataSource.getAllSets());
      expect(sets, tSets);
    });
  });

  group('getAllCards', () {
    const tInfoRequest = GetCardInfoRequest(misc: true);

    final tCards = <YgoCardModel>[
      const YgoCardModel(
        id: 1,
        name: 'name',
        type: 'type',
        desc: 'desc',
        atk: null,
        archetype: null,
        attribute: null,
        banlistInfo: null,
        cardImages: [],
        cardPrices: [],
        cardSets: null,
        def: null,
        level: null,
        linkmarkers: null,
        linkval: null,
        miscInfo: null,
        race: 'race',
        scale: null,
      ),
    ];

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getCards()).thenAnswer((_) async => []);

      // act
      repository.getAllCards(shouldReload: false);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('if offline fetch from local datasource', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getCards()).thenAnswer((_) async => tCards);

      // act
      final cards = await repository.getAllCards(shouldReload: false);

      // assert
      verify(mockLocalDataSource.getCards());
      expect(cards, tCards);
    });

    test('if online fetch from remote datasource', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCardInfo(tInfoRequest))
          .thenAnswer((_) async => tCards);

      // act
      final cards = await repository.getAllCards(shouldReload: true);

      // assert
      verify(mockRemoteDataSource.getCardInfo(tInfoRequest));
      expect(cards, tCards);
    });
  });

  group('getRandomCard', () {
    const tCard = YgoCardModel(
      archetype: '',
      atk: null,
      attribute: '',
      banlistInfo: null,
      cardImages: [],
      cardPrices: [],
      cardSets: [],
      def: null,
      desc: '',
      id: 0,
      level: null,
      linkmarkers: [],
      linkval: null,
      miscInfo: [],
      name: '',
      race: '',
      scale: null,
      type: '',
    );

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRandomCard()).thenAnswer((_) async => tCard);

      // act
      repository.getRandomCard();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('if online fetch from remote datasource', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRandomCard()).thenAnswer((_) async => tCard);

      // act
      final randomCard = await repository.getRandomCard();

      // assert
      verify(mockRemoteDataSource.getRandomCard());
      expect(randomCard, tCard);
    });

    test('if offline fetch a random card from local datasource', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getCards()).thenAnswer((_) async => tCards);

      // act
      final randomCard = await repository.getRandomCard();

      // assert
      verify(mockLocalDataSource.getCards());
      expect(tCards.contains(randomCard), true);
    });
  });

  group('getOwnedCards', () {
    final tOwnedCards = <CardOwned>[
      CardOwned(
        quantity: 1,
        setCode: '',
        edition: CardEditionEnum.first,
        setName: '',
        id: 1,
      ),
    ];

    test('fetch owned cards from local datasource', () async {
      // arrange
      when(mockLocalDataSource.getCardsOwned()).thenAnswer(
        (_) async => tOwnedCards,
      );

      // act
      final cards = await repository.getOwnedCards();

      // assert
      verify(mockLocalDataSource.getCardsOwned());
      expect(cards, tOwnedCards);
    });
  });

  group('shouldReloadDb', () {
    final tDbVersion = DbVersionModel(
      lastUpdate: DateTime.now(),
      version: '1',
    );
    final tDbVersion2 = DbVersionModel(
      lastUpdate: DateTime.now(),
      version: '2',
    );

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      repository.shouldReloadDb();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('if same version do not update and return false', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.checkDatabaseVersion()).thenAnswer(
        (_) async => tDbVersion,
      );
      when(mockLocalDataSource.getDatabaseVersion()).thenAnswer(
        (_) async => tDbVersion,
      );

      // act
      final shouldReload = await repository.shouldReloadDb();

      // assert
      verify(mockRemoteDataSource.checkDatabaseVersion());
      verify(mockLocalDataSource.getDatabaseVersion());
      expect(shouldReload, false);
    });

    test('if different version update and return true', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.checkDatabaseVersion()).thenAnswer(
        (_) async => tDbVersion2,
      );
      when(mockLocalDataSource.getDatabaseVersion()).thenAnswer(
        (_) async => tDbVersion,
      );
      when(mockLocalDataSource.updateDbVersion(tDbVersion2)).thenAnswer(
        (_) async => true,
      );

      // act
      final shouldReload = await repository.shouldReloadDb();

      // assert
      verify(mockRemoteDataSource.checkDatabaseVersion());
      verify(mockLocalDataSource.getDatabaseVersion());
      verify(mockLocalDataSource.updateDbVersion(tDbVersion2));
      expect(shouldReload, true);
    });
  });

  group('getCopiesOfCardOwned', () {
    const tKey = '1';
    const tQuantity = 1;

    test('should call getCopiesOfCardOwned from local datasource', () async {
      // arrange
      when(mockLocalDataSource.getCopiesOfCardOwned(tKey)).thenAnswer(
        (_) async => tQuantity,
      );

      // act
      final copies = await repository.getCopiesOfCardOwned(tKey);

      // assert
      verify(mockLocalDataSource.getCopiesOfCardOwned(tKey));
      expect(copies, tQuantity);
    });
  });
}
