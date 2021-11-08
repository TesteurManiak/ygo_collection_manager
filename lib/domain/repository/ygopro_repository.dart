import '../entities/card_owned.dart';
import '../entities/card_set_info.dart';
import '../entities/db_version.dart';
import '../entities/ygo_card.dart';
import '../entities/ygo_set.dart';

abstract class YgoProRepository {
  /// Returns all of the current Yu-Gi-Oh! Card Set Names.
  Future<List<YgoSet>> getAllSets();

  Future<List<YgoSet>> getLocalSets();

  /// Fetch a [List<YgoCard>] from the API.
  ///
  /// If a [ServerException] is thrown, the local data will be retried.
  Future<List<YgoCard>> getAllCards();

  /// Returns a [CardSetInfo] for the given [setCode] from the API.
  Future<CardSetInfo> getCardSetInformation(String setCode);

  Future<DbVersion> checkDatabaseVersion();

  /// Fetch a random [YgoCard] from the API.
  Future<YgoCard> getRandomCard();

  Future<List<CardOwned>> getOwnedCards();

  Future<List<YgoCard>> getLocalCards();

  Future<void> updateCards(List<YgoCard> cards);

  Future<bool> shouldReloadDb();

  Future<int> getCopiesOfCardOwned(String key);

  Future<void> updateCardOwned(CardOwned card);

  Future<void> updateSets(List<YgoSet> sets);
}
