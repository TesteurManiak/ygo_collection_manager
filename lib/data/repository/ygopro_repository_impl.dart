import 'package:flutter/foundation.dart';

import '../../core/platform/network_info.dart';
import '../../domain/entities/card_owned.dart';
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

  static Future<List<YgoSet>> _fetchSets(_) async {
    // TODO: need to refacto without the service locator
    setupLocator();
    final sets = await sl<YgoProRemoteDataSource>().getAllSets();
    return sets;
  }

  @override
  Future<List<YgoSet>> getAllSets({required bool shouldReload}) async {
    final isConnected = await networkInfo.isConnected;
    late final List<YgoSet> sets;
    if (isConnected && shouldReload) {
      // Fetch sets from remote and update the database.
      sets = await compute(_fetchSets, isConnected);
      await localDataSource.updateSets(sets);
    } else {
      sets = await localDataSource.getSets();
    }
    sets.sort((a, b) => a.setName.compareTo(b.setName));
    return sets;
  }

  @override
  Future<YgoCard> getRandomCard() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      return remoteDataSource.getRandomCard();
    }
    return ((await localDataSource.getCards())..shuffle()).first;
  }

  static Future<List<YgoCard>> _fetchCards(_) async {
    // TODO: need to refacto without the service locator
    setupLocator();
    final cards = await sl<YgoProRemoteDataSource>()
        .getCardInfo(GetCardInfoRequest(misc: true));
    return cards;
  }

  @override
  Future<List<YgoCard>> getAllCards({required bool shouldReload}) async {
    final isConnected = await networkInfo.isConnected;
    late final List<YgoCard> cards;
    if (isConnected && shouldReload) {
      // Fetch cards from remote and update the database.
      cards = await compute(_fetchCards, null);
      await localDataSource.updateCards(cards);
    } else {
      cards = await localDataSource.getCards();
    }
    cards.sort((a, b) => a.name.compareTo(b.name));
    return cards;
  }

  @override
  Future<List<CardOwned>> getOwnedCards() => localDataSource.getCardsOwned();

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
}
