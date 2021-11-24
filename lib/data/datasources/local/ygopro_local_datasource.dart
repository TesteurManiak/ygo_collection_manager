import '../../../domain/entities/card_owned.dart';
import '../../../domain/entities/db_version.dart';
import '../../../domain/entities/ygo_card.dart';
import '../../../domain/entities/ygo_set.dart';

abstract class YgoProLocalDataSource {
  Future<void> initDb();
  Future<void> closeDb();
  Future<List<YgoCard>> getCards();
  Future<DbVersion?> getDatabaseVersion();
  Future<List<YgoSet>> getSets();
  Future<void> updateCards(List<YgoCard> cards);
  Future<void> updateDbVersion(DbVersion dbVersion);
  Future<void> updateSets(List<YgoSet> sets);

  /// Getter to return a List<CardOwnedModel>.
  Future<List<CardOwned>> getCardsOwned();

  /// Return the number of copy of a specific card.
  Future<int> getCopiesOfCardOwned(String key);

  /// Return the number of copy of a card by id.
  Future<int> getCopiesOfCardOwnedById(int id);

  /// Add or update a card to the collection. Takes a [CardOwnedModel] as
  /// parameter.
  Future<void> updateCardOwned(CardOwned card);

  /// Remove a card from the collection. Takes a [CardOwnedModel] as parameter.
  Future<void> removeCard(CardOwned card);
}
