import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/data/api/api.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/response/archetype_model.dart';
import 'package:ygo_collection_manager/data/models/response/card_set_info_model.dart';
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
    const tUri = 'https://db.ygoprodeck.com/api/v7/archetypes.php?';

    final tFixture = jsonDecode(fixture('archetypes.json')) as Iterable;
    final tArchetypes = tFixture
        .cast<Map<String, dynamic>>()
        .map<Archetype>((e) => ArchetypeModel.fromJson(e))
        .toList();

    test('should perform a GET request on archetypes.php endpoint', () async {
      //arrange
      when(mockHttpClient.get(tUri)).thenAnswer((_) async => tFixture);

      //act
      final archetypes = await dataSource.getAllCardArchetypes();

      //assert
      verify(mockHttpClient.get(tUri));
      expect(archetypes, tArchetypes);
    });
  });

  group('getAllSets', () {
    const tUri = 'https://db.ygoprodeck.com/api/v7/cardsets.php?';

    final tFixture = jsonDecode(fixture('cardsets.json')) as Iterable;
    final tSets = tFixture
        .cast<Map<String, dynamic>>()
        .map<YgoSet>((e) => YgoSetModel.fromJson(e))
        .toList();

    test('should perform a GET request on cardsets.php endpoint', () async {
      //arrange
      when(mockHttpClient.get(tUri)).thenAnswer((_) async => tFixture);

      //act
      final sets = await dataSource.getAllSets();

      //assert
      verify(mockHttpClient.get(tUri));
      expect(sets, tSets);
    });
  });

  group('getCardSetInformation', () {
    const tSetCode = 'SDY-046';
    const tUri =
        'https://db.ygoprodeck.com/api/v7/cardsetsinfo.php?setcode=$tSetCode';

    final tFixture =
        jsonDecode(fixture('cardsetsinfo.json')) as Map<String, dynamic>;
    final tCardSetInfo = CardSetInfoModel.fromJson(tFixture);

    test('should perform a GET request on cardsetsinfo.php', () async {
      //arrange
      when(mockHttpClient.get(tUri)).thenAnswer((_) async => tFixture);

      //act
      final sets = await dataSource.getCardSetInformation(tSetCode);

      //assert
      verify(mockHttpClient.get(tUri));
      expect(sets, tCardSetInfo);
    });
  });

  group('getRandomCard', () {});

  group('getCardInfo', () {});

  group('checkDatabaseVersion', () {});
}
