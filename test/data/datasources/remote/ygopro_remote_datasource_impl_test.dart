import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/data/api/api.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/response/archetype_model.dart';

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
        .map<ArchetypeModel>((e) => ArchetypeModel.fromJson(e))
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
}
