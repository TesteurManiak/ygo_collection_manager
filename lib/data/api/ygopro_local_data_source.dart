import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ygo_collection_manager/extensions/list_extensions.dart';

import '../../core/error/exceptions.dart';
import '../../features/browse_cards/data/models/db_version_model.dart';
import '../../features/browse_cards/data/models/ygo_card_model.dart';
import '../../features/browse_cards/data/models/ygo_set_model.dart';
import '../../models/card_owned_model.dart';
import '../../utils/indexes.dart';

final ygoProLocalDataSourceProvider =
    Provider<YgoProLocalDataSource>((_) => YgoProLocalDataSource());

typedef _HiveCallback<T> = Future<T> Function();

class YgoProLocalDataSource {
  bool _isInitialized = false;

  late final Box<YgoCardModel> _cardsBox;
  late final Box<YgoSetModel> _setsBox;
  late final Box<DbVersionModel> _dbVersionBox;
  late final Box<CardOwnedModel> _cardsOwnedBox;

  Future<void> init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();

      // TODO: Register adapters for models

      _cardsBox = await Hive.openBox<YgoCardModel>(Indexes.tableCards);
      _setsBox = await Hive.openBox<YgoSetModel>(Indexes.tableSets);
      _dbVersionBox = await Hive.openBox<DbVersionModel>(Indexes.tableDB);
      _cardsOwnedBox =
          await Hive.openBox<CardOwnedModel>(Indexes.tableCardsOwned);
      _isInitialized = true;
    }
  }

  Future<void> dispose() => Hive.close();

  Future<List<YgoCardModel>> getCards() {
    return _checkIfInitialized<List<YgoCardModel>>(() {
      return Future.value(_cardsBox.values.toList());
    });
  }

  Future<DbVersionModel?> getDatabaseVersion() {
    return _checkIfInitialized<DbVersionModel?>(() {
      if (_dbVersionBox.isEmpty) return Future.value(null);
      return Future.value(_dbVersionBox.values.first);
    });
  }

  Future<List<YgoSetModel>> getSets() {
    return _checkIfInitialized<List<YgoSetModel>>(() {
      return Future.value(_setsBox.values.toList());
    });
  }

  Future<void> updateCards(List<YgoCardModel> cards) {
    return _checkIfInitialized<void>(() {
      final cardsMap = <int, YgoCardModel>{};
      for (final card in cards) {
        cardsMap[card.id] = card;
      }
      return _cardsBox.putAll(cardsMap);
    });
  }

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

  Future<void> updateSets(List<YgoSetModel> sets) {
    return _checkIfInitialized<void>(() {
      final setsMap = <String, YgoSetModel>{};
      for (final set in sets) {
        setsMap[set.setName] = set;
      }
      return _setsBox.putAll(setsMap);
    });
  }

  /// Getter to return a List<CardOwnedModel>.
  Future<List<CardOwnedModel>> getCardsOwned() {
    return _checkIfInitialized<List<CardOwnedModel>>(
      () => Future.value(
        _cardsOwnedBox.values
            .toList()
            .compactMap<CardOwnedModel>((e) => e.quantity > 0 ? e : null),
      ),
    );
  }

  /// Return the number of copy of a specific card.
  Future<int> getCopiesOfCardOwned(String key) {
    return _checkIfInitialized(
      () => Future.value(_cardsOwnedBox.get(key)?.quantity ?? 0),
    );
  }

  /// Return the number of copy of a card by id.
  Future<int> getCopiesOfCardOwnedById(int id) {
    return _checkIfInitialized(() async {
      int _quantity = 0;
      final cardsOwned = await getCardsOwned();
      final _cards = cardsOwned.where((card) => card.id == id);
      for (final card in _cards) {
        _quantity += card.quantity;
      }
      return _quantity;
    });
  }

  /// Add or update a card to the collection. Takes a [CardOwnedModel] as
  /// parameter.
  Future<void> updateCardOwned(CardOwnedModel card) {
    return _checkIfInitialized<void>(() {
      final keyIndex = _cardsOwnedBox.keys.toList().indexOf(card.key);
      if (keyIndex != -1) return _cardsOwnedBox.putAt(keyIndex, card);
      return _cardsOwnedBox.put(card.key, card);
    });
  }

  /// Remove a card from the collection. Takes a [CardOwnedModel] as parameter.
  Future<void> removeCard(CardOwnedModel card) {
    return _checkIfInitialized<void>(() => _cardsOwnedBox.delete(card.key));
  }

  Future<T> _checkIfInitialized<T>(_HiveCallback<T> callback) async {
    if (!_isInitialized) {
      throw const CacheException(message: 'Hive is not initialized');
    }
    return callback();
  }
}
