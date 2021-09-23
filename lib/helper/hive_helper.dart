import 'package:hive_flutter/hive_flutter.dart';
import 'package:ygo_collection_manager/extensions/extensions.dart';
import 'package:ygo_collection_manager/models/card_edition_enum.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/card_owned_model.dart';
import 'package:ygo_collection_manager/models/db_version_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/utils/indexes.dart';

class HiveHelper {
  bool _isInitialized = false;

  HiveHelper._();

  static final instance = HiveHelper._();

  late final Box<DBVersionModel> _boxDb;
  late final Box<CardInfoModel> _boxCards;
  late final Box<SetModel> _boxSets;
  late final Box<CardOwnedModel> _boxCardsOwned;

  /// Initialize Hive instance and open its boxes.
  Future<void> initHive() async {
    if (!instance._isInitialized) {
      await Hive.initFlutter();

      // Register Adapters.
      Hive.registerAdapter(DBVersionModelAdapter());
      Hive.registerAdapter(CardImagesAdapter());
      Hive.registerAdapter(CardInfoModelAdapter());
      Hive.registerAdapter(SetModelAdapter());
      Hive.registerAdapter(CardModelSetAdapter());
      Hive.registerAdapter(CardPriceModelAdapter());
      Hive.registerAdapter(CardBanlistInfoAdapter());
      Hive.registerAdapter(CardMiscInfoAdapter());
      Hive.registerAdapter(CardOwnedModelAdapter());
      Hive.registerAdapter(CardEditionEnumAdapter());

      _boxDb = await Hive.openBox<DBVersionModel>(Indexes.tableDB);
      _boxCards = await Hive.openBox<CardInfoModel>(Indexes.tableCards);
      _boxSets = await Hive.openBox<SetModel>(Indexes.tableSets);
      _boxCardsOwned =
          await Hive.openBox<CardOwnedModel>(Indexes.tableCardsOwned);
      instance._isInitialized = true;
    }
  }

  DBVersionModel? get databaseVersion {
    if (_boxDb.values.isEmpty) return null;
    return _boxDb.getAt(0);
  }

  Future<void> updateDatabaseVersion(DBVersionModel version) {
    if (databaseVersion == null) {
      return _boxDb.put(0, version);
    } else {
      return _boxDb.putAt(0, version);
    }
  }

  Iterable<CardInfoModel> get cards => _boxCards.values;

  Future<void> updateCards(List<CardInfoModel> cards) {
    final cardsMap = <int, CardInfoModel>{};
    for (final card in cards) {
      cardsMap[card.id] = card;
    }
    return _boxCards.putAll(cardsMap);
  }

  Iterable<SetModel> get sets => _boxSets.values;

  Future<void> updateSets(List<SetModel> sets) {
    final setsMap = <String, SetModel>{};
    for (final set in sets) {
      setsMap[set.setName] = set;
    }
    return _boxSets.putAll(setsMap);
  }

  Future<void> dispose() => Hive.close();

  /// Getter to return a List<CardOwnedModel>.
  List<CardOwnedModel> get cardsOwned => _boxCardsOwned.values
      .toList()
      .compactMap<CardOwnedModel>((e) => e.quantity > 0 ? e : null);

  /// Return the number of copy of a specific card.
  int getCopiesOfCardOwned(String key) =>
      _boxCardsOwned.get(key)?.quantity ?? 0;

  /// Return the number of copy of a card by id.
  int getCopiesOfCardOwnedById(int id) {
    int _quantity = 0;
    final _cards = cardsOwned.where((card) => card.id == id);
    for (final card in _cards) {
      _quantity += card.quantity;
    }
    return _quantity;
  }

  /// Add or update a card to the collection. Takes a [CardOwnedModel] as
  /// parameter.
  Future<void> updateCardOwned(CardOwnedModel card) {
    final keyIndex = _boxCardsOwned.keys.toList().indexOf(card.key);
    if (keyIndex != -1) return _boxCardsOwned.putAt(keyIndex, card);
    return _boxCardsOwned.put(card.key, card);
  }

  /// Remove a card from the collection. Takes a [CardOwnedModel] as parameter.
  Future<void> removeCard(CardOwnedModel card) {
    return _boxCardsOwned.delete(card.key);
  }
}
