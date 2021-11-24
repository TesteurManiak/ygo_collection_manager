import '../entities/card_owned.dart';
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

  /// Fetch a random [YgoCard] from the API.
  ///
  /// If there is no internet connection, a random card from the local data will
  /// be retrived.
  Future<YgoCard> getRandomCard();

  /// Return a `List<CardOwned>` from the local datasource of all the cards
  /// owned by the user..
  Future<List<CardOwned>> getOwnedCards();

  /// Fetch the `DbVersion` from the local and remote datasource.
  ///
  /// Return `false` if both `DbVersion.version` are identical or if there is no
  /// internet connection.
  ///
  /// Return `true` if there is a new version available or if there is no local
  /// version.
  Future<bool> shouldReloadDb();

  /// Return the number of a specific card owned by the user.
  ///
  /// The card is identified by its `key`.
  Future<int> getCopiesOfCardOwned(String key);

  Future<void> updateCardOwned(CardOwned card);
}
