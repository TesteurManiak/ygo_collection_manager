import 'package:hive_flutter/hive_flutter.dart';
import 'package:ygo_collection_manager/core/error/exceptions.dart';

import '../../../../utils/indexes.dart';
import '../models/db_version_model.dart';
import '../models/ygo_card_model.dart';
import '../models/ygo_set_model.dart';

abstract class YgoProLocalDataSource {
  /// Gets the latest cached array of [YgoCardModel] from the cache.
  ///
  /// Returns an empty list if no cache is available.
  Future<List<YgoCardModel>> getCards();
  Future<void> updateCards(List<YgoCardModel> cards);

  /// Gets the latest cached array of [YgoSetModel] from the cache.
  ///
  /// Returns an empty list if no cache is available.
  Future<List<YgoSetModel>> getSets();
  Future<void> updateSets(List<YgoSetModel> sets);

  /// Gets the latest cached [DbVersionModel] from the cache.
  ///
  /// Returns null if no data is cached.
  Future<DbVersionModel?> getDatabaseVersion();
  Future<void> updateDbVersion(DbVersionModel dbVersion);
}

typedef _HiveCallback<T> = Future<T> Function();

class YgoProLocalDataSourceImpl implements YgoProLocalDataSource {
  bool _isInitialized = false;

  late final Box<YgoCardModel> _cardsBox;
  late final Box<YgoSetModel> _setsBox;
  late final Box<DbVersionModel> _dbVersionBox;

  Future<void> init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();

      // TODO: Register adapters for models

      _cardsBox = await Hive.openBox<YgoCardModel>(Indexes.tableCards);
      _setsBox = await Hive.openBox<YgoSetModel>(Indexes.tableSets);
      _dbVersionBox = await Hive.openBox<DbVersionModel>(Indexes.tableDB);
      _isInitialized = true;
    }
  }

  @override
  Future<List<YgoCardModel>> getCards() {
    return _checkIfInitialized<List<YgoCardModel>>(() {
      return Future.value(_cardsBox.values.toList());
    });
  }

  @override
  Future<DbVersionModel?> getDatabaseVersion() {
    return _checkIfInitialized<DbVersionModel?>(() {
      if (_dbVersionBox.isEmpty) return Future.value(null);
      return Future.value(_dbVersionBox.values.first);
    });
  }

  @override
  Future<List<YgoSetModel>> getSets() {
    return _checkIfInitialized<List<YgoSetModel>>(() {
      return Future.value(_setsBox.values.toList());
    });
  }

  @override
  Future<void> updateCards(List<YgoCardModel> cards) {
    return _checkIfInitialized<void>(() {
      final cardsMap = <int, YgoCardModel>{};
      for (final card in cards) {
        cardsMap[card.id] = card;
      }
      return _cardsBox.putAll(cardsMap);
    });
  }

  @override
  Future<void> updateDbVersion(DbVersionModel dbVersion) async {
    return _checkIfInitialized<void>(() async {
      final _currentVersion = await getDatabaseVersion();
      if (_currentVersion == null) {
        return _dbVersionBox.put(0, dbVersion);
      } else {
        return _dbVersionBox.putAt(0, dbVersion);
      }
    });
  }

  @override
  Future<void> updateSets(List<YgoSetModel> sets) {
    return _checkIfInitialized<void>(() {
      final setsMap = <String, YgoSetModel>{};
      for (final set in sets) {
        setsMap[set.setName] = set;
      }
      return _setsBox.putAll(setsMap);
    });
  }

  Future<T> _checkIfInitialized<T>(_HiveCallback<T> callback) async {
    if (!_isInitialized) {
      throw CacheException(message: 'Hive is not initialized');
    }
    return callback();
  }
}
