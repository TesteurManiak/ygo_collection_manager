import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/data/api/api.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/request/get_card_info_request.dart';
import 'package:ygo_collection_manager/data/models/response/archetype_model.dart';
import 'package:ygo_collection_manager/data/models/response/card_set_info_model.dart';
import 'package:ygo_collection_manager/data/models/response/db_version_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_set_model.dart';
import 'package:ygo_collection_manager/domain/entities/archetype.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';

import '../../../utils/fixture_reader.dart';
import 'ygopro_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([RemoteClient])
void main() {
  final mockHttpClient = MockRemoteClient();
  final dataSource = YgoProRemoteDataSourceImpl(httpClient: mockHttpClient);

  group('getAllCardArchetypes', () {
    final tFixture = jsonDecode(fixture('archetypes.json')) as Iterable;
    final tArchetypes = tFixture
        .cast<Map<String, dynamic>>()
        .map<Archetype>((e) => ArchetypeModel.fromJson(e))
        .toList();

    test('should perform a GET request on archetypes.php endpoint', () async {
      //arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => tFixture);

      //act
      final archetypes = await dataSource.getAllCardArchetypes();

      //assert
      verify(mockHttpClient.get(any));
      expect(archetypes, tArchetypes);
    });
  });

  group('getAllSets', () {
    final tFixture = jsonDecode(fixture('cardsets.json')) as Iterable;
    final tSets = tFixture
        .cast<Map<String, dynamic>>()
        .map<YgoSet>((e) => YgoSetModel.fromJson(e))
        .toList();

    test('should perform a GET request on cardsets.php endpoint', () async {
      //arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => tFixture);

      //act
      final sets = await dataSource.getAllSets();

      //assert
      verify(mockHttpClient.get(any));
      expect(sets, tSets);
    });
  });

  group('getCardSetInformation', () {
    const tSetCode = 'SDY-046';

    final tFixture =
        jsonDecode(fixture('cardsetsinfo.json')) as Map<String, dynamic>;
    final tCardSetInfo = CardSetInfoModel.fromJson(tFixture);

    test('should perform a GET request on cardsetsinfo.php endpoint', () async {
      //arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => tFixture);

      //act
      final sets = await dataSource.getCardSetInformation(tSetCode);

      //assert
      verify(mockHttpClient.get(any));
      expect(sets, tCardSetInfo);
    });
  });

  group('getRandomCard', () {
    final tFixture =
        jsonDecode(fixture('randomcard.json')) as Map<String, dynamic>;
    final tCard = YgoCardModel.fromJson(tFixture);

    test('should perform a GET request on randomcard.php endpoint', () async {
      //arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => tFixture);

      //act
      final randCard = await dataSource.getRandomCard();

      //assert
      verify(mockHttpClient.get(any));
      expect(randCard, tCard);
    });
  });

  group('getCardInfo', () {
    const tRequest = GetCardInfoRequest();
    const tFname = 'Magician';

    final tFixture =
        jsonDecode(fixture('cardinfo.json')) as Map<String, dynamic>;
    final tCards = (tFixture['data'] as Iterable)
        .cast<Map<String, dynamic>>()
        .map((e) => YgoCardModel.fromJson(e));
    final tNames = <String>['test1', 'test2'];

    test('should perform a GET request on cardinfo.php endpoint', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => tFixture);

      // act
      final cardInfo = await dataSource.getCardInfo(tRequest);

      // assert
      verify(mockHttpClient.get(any));
      expect(cardInfo, tCards);
    });

    test('check names', () async {
      // arrange
      final tNamesRequest = YgoProRemoteDataSourceImpl.baseUrl.replace(
        pathSegments: [
          ...YgoProRemoteDataSourceImpl.baseUrl.pathSegments,
          YgoProRemoteDataSourceImpl.cardSetsInfoPath,
        ],
        queryParameters: {'name': tNames.join(',')},
      ).toString();
      when(mockHttpClient.get(tNamesRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(names: tNames));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check fname', () async {
      // arrange
      final tFNamesRequest = YgoProRemoteDataSourceImpl.baseUrl.replace(
        pathSegments: [
          ...YgoProRemoteDataSourceImpl.baseUrl.pathSegments,
          YgoProRemoteDataSourceImpl.cardSetsInfoPath,
        ],
        queryParameters: {'fname': tFname},
      ).toString();
      when(mockHttpClient.get(tFNamesRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(fname: tFname));

      // assert
      verify(mockHttpClient.get(any));
    });
  });

  group('checkDatabaseVersion', () {
    final tFixture = jsonDecode(fixture('checkDBVer.json')) as Iterable;
    final tVersion = DbVersionModel.fromJson(
      tFixture.cast<Map<String, dynamic>>().first,
    );

    test('should perform GET request on checkDBVer.php endpoint', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => tFixture);

      // act
      final version = await dataSource.checkDatabaseVersion();

      // assert
      verify(mockHttpClient.get(any));
      expect(version, tVersion);
    });
  });

  group('parseSets', () {
    test(
      'should parse the file cardsets.json into an array of YgoSetModel',
      () async {
        // arrange
        final tFixture = jsonDecode(fixture('cardsets.json')) as Iterable;
        final tSets = tFixture
            .cast<Map<String, dynamic>>()
            .map((e) => YgoSetModel.fromJson(e))
            .toList();

        // act
        final sets = YgoProRemoteDataSourceImpl.parseSets(tFixture);

        // assert
        expect(sets, tSets);
      },
    );
  });

  group('parseCards', () {
    test(
      'should parse the file cardinfo.json into an array of YgoCardModel',
      () async {
        // arrange
        final tFixture =
            jsonDecode(fixture('cardinfo.json')) as Map<String, dynamic>;
        final tCards = (tFixture['data'] as Iterable)
            .cast<Map<String, dynamic>>()
            .map((e) => YgoCardModel.fromJson(e));

        // act
        final cards = YgoProRemoteDataSourceImpl.parseCards(tFixture);

        // assert
        expect(cards, tCards);
      },
    );
  });
}
