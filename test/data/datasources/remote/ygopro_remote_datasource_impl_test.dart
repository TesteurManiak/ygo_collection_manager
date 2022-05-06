import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/request/get_card_info_request.dart';
import 'package:ygo_collection_manager/data/models/response/archetype_model.dart';
import 'package:ygo_collection_manager/data/models/response/card_set_info_model.dart';
import 'package:ygo_collection_manager/data/models/response/db_version_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_set_model.dart';
import 'package:ygo_collection_manager/domain/entities/archetype.dart';
import 'package:ygo_collection_manager/domain/entities/banlist.dart';
import 'package:ygo_collection_manager/domain/entities/format.dart';
import 'package:ygo_collection_manager/domain/entities/link_markers.dart';
import 'package:ygo_collection_manager/domain/entities/sort.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';

import '../../../utils/fixture_reader.dart';
import '../../../utils/mocks.dart';

void main() {
  final mockHttpClient = MockRemoteClient();
  final dataSource = YgoProRemoteDataSourceImpl(httpClient: mockHttpClient);

  group('getAllCardArchetypes', () {
    final tFixture = jsonDecode(fixture('archetypes.json')) as Iterable;
    final tArchetypes = tFixture
        .cast<Map<String, dynamic>>()
        .map<Archetype>(ArchetypeModel.fromJson)
        .toList();

    test('should perform a GET request on archetypes.php endpoint', () async {
      //arrange
      final url = _createUrl([YgoProRemoteDataSourceImpl.archetypesPath]);
      when(() => mockHttpClient.get(url)).thenAnswer((_) async => tFixture);

      //act
      final archetypes = await dataSource.getAllCardArchetypes();

      //assert
      verify(() => mockHttpClient.get(url));
      expect(archetypes, tArchetypes);
    });
  });

  group('getAllSets', () {
    final tFixture = jsonDecode(fixture('cardsets.json')) as Iterable;
    final tSets = tFixture
        .cast<Map<String, dynamic>>()
        .map<YgoSet>(YgoSetModel.fromJson)
        .toList();

    test('should perform a GET request on cardsets.php endpoint', () async {
      //arrange
      final url = _createUrl([YgoProRemoteDataSourceImpl.setsPath]);
      when(() => mockHttpClient.get(url)).thenAnswer((_) async => tFixture);

      //act
      final sets = await dataSource.getAllSets();

      //assert
      verify(() => mockHttpClient.get(url));
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
      final url = _createUrl(
        [YgoProRemoteDataSourceImpl.cardSetsInfoPath],
        queryParameters: {'setcode': tSetCode},
      );
      when(() => mockHttpClient.get(url)).thenAnswer((_) async => tFixture);

      //act
      final sets = await dataSource.getCardSetInformation(tSetCode);

      //assert
      verify(() => mockHttpClient.get(url));
      expect(sets, tCardSetInfo);
    });
  });

  group('getRandomCard', () {
    final tFixture =
        jsonDecode(fixture('randomcard.json')) as Map<String, dynamic>;
    final tCard = YgoCardModel.fromJson(tFixture);

    test('should perform a GET request on randomcard.php endpoint', () async {
      //arrange
      final url = _createUrl([YgoProRemoteDataSourceImpl.randomCardPath]);
      when(() => mockHttpClient.get(url)).thenAnswer((_) async => tFixture);

      //act
      final randCard = await dataSource.getRandomCard();

      //assert
      verify(() => mockHttpClient.get(url));
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
        YgoProRemoteDataSourceImpl.cardInfoPath,
      ],
    );
    final tFixture =
        jsonDecode(fixture('cardinfo.json')) as Map<String, dynamic>;
    final tCards = (tFixture['data'] as Iterable)
        .cast<Map<String, dynamic>>()
        .map(YgoCardModel.fromJson);
    final tStartDate = DateTime.now();
    final tEndDate = DateTime.now();
    final tDateRegion = DateTime.now();

    test('should perform a GET request on cardinfo.php endpoint', () async {
      // arrange
      final url = tBaseUri.replace(
        queryParameters: {'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(url)).thenAnswer((_) async => tFixture);

      // act
      final cardInfo = await dataSource.getCardInfo(tRequest);

      // assert
      verify(() => mockHttpClient.get(url));
      expect(cardInfo, tCards);
    });

    test('check names', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'name': tNames.join('|'), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(names: tNames));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check fname', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'fname': tFname, 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(fname: tFname));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check ids', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'id': tIds.join(','), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(ids: tIds));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check types', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'type': tTypes.join(','), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(types: tTypes));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check atk', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'atk': tAtk.toString(), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(atk: tAtk));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check def', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'def': tDef.toString(), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(def: tDef));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check level', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'level': tLevel.toString(), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(level: tLevel));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check races', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'race': tRaces.join(','), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(races: tRaces));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check attributes', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'attribute': tAttributes.join(','), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource
          .getCardInfo(const GetCardInfoRequest(attributes: tAttributes));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check link', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'link': tLink.toString(), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(link: tLink));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check linkmarkers', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {
          'linkmarker': tLinkMarkers.toStringIterable().join(','),
          'misc': 'no'
        },
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource
          .getCardInfo(const GetCardInfoRequest(linkMarkers: tLinkMarkers));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check scale', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'scale': tScale.toString(), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(scale: tScale));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check cardset', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'cardset': tCardSet, 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(cardSet: tCardSet));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check archetype', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'archetype': tArchetype, 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource
          .getCardInfo(const GetCardInfoRequest(archetype: tArchetype));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check banlist', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'banlist': tBanlist.name.toUpperCase(), 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(banlist: tBanlist));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check sort', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'sort': tSort.string, 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(sort: tSort));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check format', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'format': tFormat.string, 'misc': 'no'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(format: tFormat));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check staple', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {'misc': 'no', 'staple': 'yes'},
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(const GetCardInfoRequest(staple: tStaple));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check startDate', () async {
      // arrange
      final request = tBaseUri.replace(
        queryParameters: {
          'misc': 'no',
          'startdate': tStartDate.toIso8601String(),
        },
      ).toString();
      when(() => mockHttpClient.get(request)).thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(startDate: tStartDate));

      // assert
      verify(() => mockHttpClient.get(request));
    });

    test('check endDate', () async {
      // arrange
      final tEndDateRequest = tBaseUri.replace(
        queryParameters: {'misc': 'no', 'enddate': tEndDate.toIso8601String()},
      ).toString();
      when(() => mockHttpClient.get(tEndDateRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(endDate: tEndDate));

      // assert
      verify(() => mockHttpClient.get(tEndDateRequest));
    });

    test('check dateRegion', () async {
      // arrange
      final tDateRegionRequest = tBaseUri.replace(
        queryParameters: {
          'misc': 'no',
          'dateregion': tDateRegion.toIso8601String(),
        },
      ).toString();
      when(() => mockHttpClient.get(tDateRegionRequest))
          .thenAnswer((_) async => tFixture);

      // act
      await dataSource.getCardInfo(GetCardInfoRequest(dateRegion: tDateRegion));

      // assert
      verify(() => mockHttpClient.get(tDateRegionRequest));
    });
  });

  group('checkDatabaseVersion', () {
    final tFixture = jsonDecode(fixture('checkDBVer.json')) as Iterable;
    final tVersion = DbVersionModel.fromJson(
      tFixture.cast<Map<String, dynamic>>().first,
    );

    test('should perform GET request on checkDBVer.php endpoint', () async {
      // arrange
      final url = _createUrl([YgoProRemoteDataSourceImpl.checkDBVerPath]);
      when(() => mockHttpClient.get(url)).thenAnswer((_) async => tFixture);

      // act
      final version = await dataSource.checkDatabaseVersion();

      // assert
      verify(() => mockHttpClient.get(url));
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
            .map(YgoSetModel.fromJson)
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
            .map(YgoCardModel.fromJson);

        // act
        final cards = YgoProRemoteDataSourceImpl.parseCards(tFixture);

        // assert
        expect(cards, tCards);
      },
    );
  });
}

String _createUrl(Iterable<String> pathSegments,
    {Map<String, String> queryParameters = const {}}) {
  return YgoProRemoteDataSourceImpl.baseUrl.replace(
    pathSegments: [
      ...YgoProRemoteDataSourceImpl.baseUrl.pathSegments,
      ...pathSegments,
    ],
    queryParameters: queryParameters,
  ).toString();
}
