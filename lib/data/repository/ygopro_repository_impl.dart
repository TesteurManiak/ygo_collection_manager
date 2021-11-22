import 'package:flutter/foundation.dart';

import '../../core/platform/network_info.dart';
import '../../domain/entities/card_owned.dart';
import '../../domain/entities/card_set_info.dart';
import '../../domain/entities/db_version.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/repository/ygopro_repository.dart';
import '../../service_locator.dart';
import '../datasources/local/ygopro_local_datasource.dart';
import '../datasources/remote/ygopro_remote_data_source.dart';
import '../models/request/get_card_info_request.dart';

class YgoProRepositoryImpl implements YgoProRepository {
  final YgoProRemoteDataSource remoteDataSource;
  final YgoProLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  YgoProRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  static Future<List<YgoSet>> _fetchSets(bool isConnected) async {
    // TODO: need to refacto without the service locator
    setupLocator();
    late final List<YgoSet> sets;
    if (isConnected) {
      sets = await sl<YgoProRemoteDataSource>().getAllSets();
    } else {
      sets = await sl<YgoProLocalDataSource>().getSets();
    }
    sets.sort((a, b) => a.setName.compareTo(b.setName));
    return sets;
  }

  @override
  Future<List<YgoSet>> getAllSets() async {
    final isConnected = await networkInfo.isConnected;
    final _sets = await compute(_fetchSets, isConnected);
    return _sets;
  }

  @override
  Future<CardSetInfo> getCardSetInformation(String setCode) =>
      remoteDataSource.getCardSetInformation(setCode);

  @override
  Future<YgoCard> getRandomCard() => remoteDataSource.getRandomCard();

  static Future<List<YgoCard>> _fetchCards(_) async {
    // TODO: need to refacto without the service locator
    setupLocator();
    final cards = await sl<YgoProRemoteDataSource>()
        .getCardInfo(GetCardInfoRequest(misc: true));
    cards.sort((a, b) => a.name.compareTo(b.name));
    return cards;
  }

  @override
  Future<List<YgoCard>> getAllCards() async {
    final cards = await compute(_fetchCards, null);
    return cards;
  }

  @override
  Future<DbVersion> checkDatabaseVersion() =>
      remoteDataSource.checkDatabaseVersion();

  @override
  Future<List<CardOwned>> getOwnedCards() => localDataSource.getCardsOwned();

  @override
  Future<List<YgoCard>> getLocalCards() async {
    final cards = await localDataSource.getCards();
    cards.sort((a, b) => a.name.compareTo(b.name));
    return cards;
  }

  @override
  Future<void> updateCards(List<YgoCard> cards) =>
      localDataSource.updateCards(cards);

  @override
  Future<bool> shouldReloadDb() async {
    final savedDbVersion = await localDataSource.getDatabaseVersion();
    final fetchedDbVersion = await remoteDataSource.checkDatabaseVersion();

    final shouldReload = savedDbVersion == null ||
        savedDbVersion.version != fetchedDbVersion.version;
    if (shouldReload) {
      await localDataSource.updateDbVersion(fetchedDbVersion);
    }
    return shouldReload;
  }

  @override
  Future<int> getCopiesOfCardOwned(String key) =>
      localDataSource.getCopiesOfCardOwned(key);

  @override
  Future<void> updateCardOwned(CardOwned card) =>
      localDataSource.updateCardOwned(card);

  @override
  Future<List<YgoSet>> getLocalSets() async {
    final sets = await localDataSource.getSets();
    sets.sort((a, b) => a.setName.compareTo(b.setName));
    return sets;
  }

  @override
  Future<void> updateSets(List<YgoSet> sets) =>
      localDataSource.updateSets(sets);
}
