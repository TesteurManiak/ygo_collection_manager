import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/core/platform/network_info.dart';
import 'package:ygo_collection_manager/data/datasources/local/ygopro_local_datasource.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';
import 'package:ygo_collection_manager/data/repository/ygopro_repository_impl.dart';

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
  });
}
