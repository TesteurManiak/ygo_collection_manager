import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/core/entities/banlist.dart';
import 'package:ygo_collection_manager/core/entities/format.dart';
import 'package:ygo_collection_manager/core/entities/link_markers.dart';
import 'package:ygo_collection_manager/core/entities/sort.dart';
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
    const tNames = ['test1', 'test2'];
    const tFname = 'Magician';
    const tIds = [1, 2, 3];
    const tTypes = ['Effect Monster', 'Flip Effect Monster'];
    const tAtk = 0;
    const tDef = 0;
    const tLevel = 1;
    const tRaces = ['Aqua', 'Beast'];
    const tAttributes = ['WATER', 'DARK'];
    const tLink = 1;
    const tLinkMarkers = [LinkMarkers.bottom];
    const tScale = 1;
    const tCardSet = 'Metal Raiders';
    const tArchetype = 'Blue-Eyes';
    const tBanlist = Banlist.tcg;
    const tSort = Sort.name;
    const tFormat = Format.tcg;
    const tStaple = true;

    final tBaseUri = YgoProRemoteDataSourceImpl.baseUrl.replace(
      pathSegments: [
        ...YgoProRemoteDataSourceImpl.baseUrl.pathSegments,
        YgoProRemoteDataSourceImpl.cardSetsInfoPath,
      ],
    );
    final tFixture =
        jsonDecode(fixture('cardinfo.json')) as Map<String, dynamic>;
    final tCards = (tFixture['data'] as Iterable)
        .cast<Map<String, dynamic>>()
        .map((e) => YgoCardModel.fromJson(e));
    final tStartDate = DateTime.now();
    final tEndDate = DateTime.now();
    final tDateRegion = DateTime.now();

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
      final tNamesRequest = tBaseUri.replace(
        queryParameters: {'name': tNames.join(',')},
      ).toString();
      when(mockHttpClient.get(tNamesRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(names: tNames));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check fname', () async {
      // arrange
      final tFNamesRequest = tBaseUri.replace(
        queryParameters: {'fname': tFname},
      ).toString();
      when(mockHttpClient.get(tFNamesRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(fname: tFname));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check ids', () async {
      // arrange
      final tIdsRequest = tBaseUri.replace(
        queryParameters: {'id': tIds.join(',')},
      ).toString();
      when(mockHttpClient.get(tIdsRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(ids: tIds));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check types', () async {
      // arrange
      final tTypesRequest = tBaseUri.replace(
        queryParameters: {'type': tTypes.join(',')},
      ).toString();
      when(mockHttpClient.get(tTypesRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(types: tTypes));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check atk', () async {
      // arrange
      final tAtkRequest = tBaseUri.replace(
        queryParameters: {'atk': tAtk.toString()},
      ).toString();
      when(mockHttpClient.get(tAtkRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(atk: tAtk));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check def', () async {
      // arrange
      final tDefRequest = tBaseUri.replace(
        queryParameters: {'def': tDef.toString()},
      ).toString();
      when(mockHttpClient.get(tDefRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(def: tDef));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check level', () async {
      // arrange
      final tLevelRequest = tBaseUri.replace(
        queryParameters: {'level': tLevel.toString()},
      ).toString();
      when(mockHttpClient.get(tLevelRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(level: tLevel));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check races', () async {
      // arrange
      final tRacesRequest = tBaseUri.replace(
        queryParameters: {'race': tRaces.join(',')},
      ).toString();
      when(mockHttpClient.get(tRacesRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(races: tRaces));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check attributes', () async {
      // arrange
      final tAttributesRequest = tBaseUri.replace(
        queryParameters: {'attribute': tAttributes.join(',')},
      ).toString();
      when(mockHttpClient.get(tAttributesRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource
          .getCardInfo(const GetCardInfoRequest(attributes: tAttributes));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check link', () async {
      // arrange
      final tLinkRequest = tBaseUri.replace(
        queryParameters: {'link': tLink.toString()},
      ).toString();
      when(mockHttpClient.get(tLinkRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(link: tLink));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check linkmarkers', () async {
      // arrange
      final tLinkMarkersRequest = tBaseUri.replace(
        queryParameters: {
          'linkmarkers': tLinkMarkers.toStringIterable().join(','),
        },
      ).toString();
      when(mockHttpClient.get(tLinkMarkersRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource
          .getCardInfo(const GetCardInfoRequest(linkMarkers: tLinkMarkers));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check scale', () async {
      // arrange
      final tScaleRequest = tBaseUri.replace(
        queryParameters: {'scale': tScale.toString()},
      ).toString();
      when(mockHttpClient.get(tScaleRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(scale: tScale));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check cardset', () async {
      // arrange
      final tCardSetRequest = tBaseUri.replace(
        queryParameters: {'cardset': tCardSet},
      ).toString();
      when(mockHttpClient.get(tCardSetRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(cardSet: tCardSet));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check archetype', () async {
      // arrange
      final tArchetypeRequest = tBaseUri.replace(
        queryParameters: {'archetype': tArchetype},
      ).toString();
      when(mockHttpClient.get(tArchetypeRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource
          .getCardInfo(const GetCardInfoRequest(archetype: tArchetype));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check banlist', () async {
      // arrange
      final tBanlistRequest = tBaseUri.replace(
        queryParameters: {'banlist': tBanlist.string},
      ).toString();
      when(mockHttpClient.get(tBanlistRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(banlist: tBanlist));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check sort', () async {
      // arrange
      final tSortRequest = tBaseUri.replace(
        queryParameters: {'sort': tSort.string},
      ).toString();
      when(mockHttpClient.get(tSortRequest)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(sort: tSort));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check format', () async {
      // arrange
      final tFormatRequest = tBaseUri.replace(
        queryParameters: {'format': tFormat.string},
      ).toString();
      when(mockHttpClient.get(tFormatRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(format: tFormat));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check staple', () async {
      // arrange
      final tStapleRequest = tBaseUri.replace(
        queryParameters: {'staple': tStaple.toString()},
      ).toString();
      when(mockHttpClient.get(tStapleRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(staple: tStaple));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check startDate', () async {
      // arrange
      final tStartDateRequest = tBaseUri.replace(
        queryParameters: {'startDate': tStartDate.toString()},
      ).toString();
      when(mockHttpClient.get(tStartDateRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(startDate: tStartDate));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check endDate', () async {
      // arrange
      final tEndDateRequest = tBaseUri.replace(
        queryParameters: {'endDate': tEndDate.toString()},
      ).toString();
      when(mockHttpClient.get(tEndDateRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(endDate: tEndDate));

      // assert
      verify(mockHttpClient.get(any));
    });

    test('check dateRegion', () async {
      // arrange
      final tDateRegionRequest = tBaseUri.replace(
        queryParameters: {'dateRegion': tDateRegion.toString()},
      ).toString();
      when(mockHttpClient.get(tDateRegionRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(dateRegion: tDateRegion));

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
