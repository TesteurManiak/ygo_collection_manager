import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/core/platform/network_info.dart';
import 'package:ygo_collection_manager/data/datasources/local/ygopro_local_datasource.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_set_model.dart';
import 'package:ygo_collection_manager/data/repository/ygopro_repository_impl.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';

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
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: [],
    ),
  );

  group('getAllSets', () {
    final tSets = <YgoSet>[
      YgoSetModel(
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
  });

  group('getAllCards', () {
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
      expect(cards, tCards);
      verify(mockLocalDataSource.getCards());
    });
  });

  group('getRandomCard', () {
    final tCard = YgoCardModel(
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
}
