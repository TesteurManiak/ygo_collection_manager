import '../entities/card_owned.dart';
import '../entities/card_set_info.dart';
import '../entities/db_version.dart';
import '../entities/ygo_card.dart';
import '../entities/ygo_set.dart';

abstract class YgoProRepository {
  /// Returns a `List<YgoSet>` of all the sets.
  ///
  /// If the device is online, fetch data from the remote datasource and update
  /// the local datasource.
  ///
  /// If the device is offline, fetch data from the local datasource.
  Future<List<YgoSet>> getAllSets({required bool shouldReload});

  /// Return a `List<YgoCard>` of all the cards.
  ///
  /// If the device is online, fetch data from the remote datasource and update
  /// the local datasource.
  ///
  /// If the device is offline, fetch a the cards from the local datasource.
  Future<List<YgoCard>> getAllCards({required bool shouldReload});

  /// Returns a [CardSetInfo] for the given [setCode] from the API.
  Future<CardSetInfo> getCardSetInformation(String setCode);

  Future<DbVersion> checkDatabaseVersion();

  /// Fetch a random [YgoCard] from the API.
  ///
  /// If there is no internet connection, a random card from the local data will
  /// be retrived.
  Future<YgoCard> getRandomCard();

  Future<List<CardOwned>> getOwnedCards();

  Future<bool> shouldReloadDb();

  Future<int> getCopiesOfCardOwned(String key);

  Future<void> updateCardOwned(CardOwned card);
}
