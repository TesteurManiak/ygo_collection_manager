import 'package:hive_flutter/hive_flutter.dart';

import '../../core/entities/card_edition_enum.dart';
import '../../domain/entities/card_banlist_info.dart';
import '../../domain/entities/card_images.dart';
import '../../domain/entities/card_misc_info.dart';
import '../../domain/entities/card_price.dart';
import '../../domain/entities/card_set.dart';
import '../../domain/entities/db_version.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../extensions/list_extensions.dart';
import '../../models/card_owned_model.dart';
import '../../utils/indexes.dart';

class YgoProLocalDataSource {
  late final Box<YgoCard> _cardsBox;
  late final Box<YgoSet> _setsBox;
  late final Box<DbVersion> _dbVersionBox;
  late final Box<CardOwnedModel> _cardsOwnedBox;

  Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters.
    Hive.registerAdapter(DbVersionAdapter());

    Hive.registerAdapter(YgoCardAdapter());
    Hive.registerAdapter(CardImagesAdapter());
    Hive.registerAdapter(CardSetAdapter());
    Hive.registerAdapter(CardPriceAdapter());
    Hive.registerAdapter(CardBanlistInfoAdapter());
    Hive.registerAdapter(CardMiscInfoAdapter());

    Hive.registerAdapter(YgoSetAdapter());
    Hive.registerAdapter(CardOwnedModelAdapter());
    Hive.registerAdapter(CardEditionEnumAdapter());

    _cardsBox = await Hive.openBox<YgoCard>(Indexes.tableCards);
    _setsBox = await Hive.openBox<YgoSet>(Indexes.tableSets);
    _dbVersionBox = await Hive.openBox<DbVersion>(Indexes.tableDB);
    _cardsOwnedBox =
        await Hive.openBox<CardOwnedModel>(Indexes.tableCardsOwned);
  }

  Future<List<YgoCard>> getCards() {
    return Future.value(_cardsBox.values.toList());
  }

  Future<DbVersion?> getDatabaseVersion() {
    if (_dbVersionBox.isEmpty) return Future.value(null);
    return Future.value(_dbVersionBox.values.first);
  }

  Future<List<YgoSet>> getSets() {
    return Future.value(_setsBox.values.toList());
  }

  Future<void> updateCards(List<YgoCard> cards) {
    final cardsMap = <int, YgoCard>{};
    for (final card in cards) {
      cardsMap[card.id] = card;
    }
    return _cardsBox.putAll(cardsMap);
  }

  Future<void> updateDbVersion(DbVersion dbVersion) async {
    final _currentVersion = await getDatabaseVersion();
    if (_currentVersion == null) {
      return _dbVersionBox.put(0, dbVersion);
    } else {
      return _dbVersionBox.putAt(0, dbVersion);
    }
  }

  Future<void> updateSets(List<YgoSet> sets) {
    final setsMap = <String, YgoSet>{};
    for (final set in sets) {
      setsMap[set.setName] = set;
    }
    return _setsBox.putAll(setsMap);
  }

  /// Getter to return a List<CardOwnedModel>.
  Future<List<CardOwnedModel>> getCardsOwned() {
    return Future.value(
      _cardsOwnedBox.values
          .toList()
          .compactMap<CardOwnedModel>((e) => e.quantity > 0 ? e : null),
    );
  }

  /// Return the number of copy of a specific card.
  Future<int> getCopiesOfCardOwned(String key) {
    return Future.value(_cardsOwnedBox.get(key)?.quantity ?? 0);
  }

  /// Return the number of copy of a card by id.
  Future<int> getCopiesOfCardOwnedById(int id) async {
    int _quantity = 0;
    final cardsOwned = await getCardsOwned();
    final _cards = cardsOwned.where((card) => card.id == id);
    for (final card in _cards) {
      _quantity += card.quantity;
    }
    return _quantity;
  }

  /// Add or update a card to the collection. Takes a [CardOwnedModel] as
  /// parameter.
  Future<void> updateCardOwned(CardOwnedModel card) {
    final keyIndex = _cardsOwnedBox.keys.toList().indexOf(card.key);
    if (keyIndex != -1) return _cardsOwnedBox.putAt(keyIndex, card);
    return _cardsOwnedBox.put(card.key, card);
  }

  /// Remove a card from the collection. Takes a [CardOwnedModel] as parameter.
  Future<void> removeCard(CardOwnedModel card) {
    return _cardsOwnedBox.delete(card.key);
  }
}
