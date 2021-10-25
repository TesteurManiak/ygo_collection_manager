import '../models/db_version_model.dart';
import '../models/ygo_card_model.dart';

abstract class YgoProLocalDataSource {
  /// Gets the latest cached array of [YgoCardModel] from the cache.
  ///
  /// Throws [CacheException] if no data is cached.
  Future<List<YgoCardModel>> getCards();
  Future<void> updateCards(List<YgoCardModel> cards);

  /// Gets the latest cached [DbVersionModel] from the cache.
  ///
  /// Throws [CacheException] if no data is cached.
  Future<DbVersionModel> getDbVersion();
  Future<void> updateDbVersion(DbVersionModel dbVersion);
}
